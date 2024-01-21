const express = require('express');
const path = require('path');
const mysql = require('mysql2');
const port = 3000; // Change to your desired port

const app = express();
app.use(express.urlencoded({extended:false}));
app.set('view', path.join(__dirname, 'view'));
app.use(express.json());

const dbConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'medicationhub2',
    port: '3306'
})

dbConnection.connect((err) => {
    if(err){
        console.log('Error connecting to MySQL database = ', err)
        return;
    }
    console.log('MySQL successfully connected!');
})

// CREATE Routes
//LOGIN

app.post("/login1", (req, res) => {
  const { email, password } = req.body;

  // Check if the user exists in the patient table
  dbConnection.query("SELECT * FROM patient WHERE patientEmail = ? AND patientPassword = ?", 
  [email, password], (err, patientResults, fields) => {
    if (err) {
      console.log(err);
      return res.status(400).json({ message: "Login failed." });
    }
    if (patientResults.length > 0) {
      const user = patientResults[0];
      const userData = {
        userId: user.patientId,
        firstname: user.patientFirstname,
        lastname: user.patientLastname,
        email: user.patientEmail,
      };
      return res.status(200).json({ message: 'Patient login successful', user: userData });
    } else {
      // If not found in the patient table, check the doctor table
      dbConnection.query("SELECT * FROM doctor WHERE doctorEmail = ? AND doctorPassword = ?", 
      [email, password], (err, doctorResults, fields) => {
        if (err) {
          console.log(err);
          return res.status(400).json({ message: "Login failed." });
        }

        if (doctorResults.length > 0) {
          const user = doctorResults[0];
          const userData = {
            doctorId: user.doctorId,
            name: user.doctorName,
            email: user.doctorEmail,
            picture: user.doctorPicture,
          };
          return res.status(200).json({ message: 'Doctor login successful', user: userData });
        } else {
          return res.status(401).json({ message: "Invalid email or password." });
        }
      });
    }
  });
});

//REGISTER
app.post("/register", (req, res) => {

    const { patientEmail, patientPassword, patientFirstname, patientLastname,patientCitizenId, patientAddress, patientPhoneNumber, patientGender } = req.body;
  
    const sql = "INSERT INTO patient (patientEmail, patientPassword, patientFirstname, patientLastname, patientCitizenId, patientAddress, patientPhoneNumber, patientGender) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
  
    dbConnection.query(sql, [patientEmail, patientPassword, patientFirstname, patientLastname,patientCitizenId, patientAddress, patientPhoneNumber, patientGender], (err, results) => {
      if (err) {
        console.log("Error while inserting a user into the database", err);
        return res.status(400).json({ message: "Failed to create a new user." });
      }
      return res.status(201).json({ message: "New user successfully created!" });
    });
})

//push confirmation
app.post("/appointment", (req, res) => {

  const { patientId, doctorId, departmentName, hospitalName, appointmentDate, appointmentTime, appointmentStatus } = req.body;

  const sql = "INSERT INTO appointment (patientId, doctorId, departmentName, hospitalName, appointmentDate, appointmentTime, appointmentStatus) VALUES (?, ?, ?, ?, ?, ?, ?)";

  dbConnection.query(sql, [patientId, doctorId, departmentName, hospitalName, appointmentDate, appointmentTime, appointmentStatus], (err, results) => {
    if (err) {
      console.log("Error while inserting a appointment into the database", err);
      return res.status(400).json({ message: "Failed to create a new appointment." });
    }
    return res.status(201).json({ message: "New appointment successfully created!" });
  });
})

app.post('/create-appointment', (req, res) => {
  const {
    appointment_id,
    appointmentDate,
    appointmentTime,
    patientId,
    doctorId,
    departmentName,
    hospitalName,
  } = req.body;

  const appointmentData = {
    appointmentDate: appointmentDate,
    appointmentTime: appointmentTime,
    patientId: patientId,
    doctorId: doctorId,
    departmentName: departmentName,
    hospitalName: hospitalName,
    appointmentStatus: 'Pending',
  };

  dbConnection.query('INSERT INTO appointment SET ?', appointmentData, (err, results) => {
    if (err) {
      console.error('Error creating new appointment:', err);
      return res.status(500).json({ error: 'Internal Server Error' });
    }

    res.status(201).json({ message: 'Appointment created successfully', appointmentId: results.insertId });
  });
});


//READ
app.get("/read", async (req, res) => {
  try{
    dbConnection.query("SELECT * FROM doctor", (err, results, fields) => {
      if (err) {
        console.log(err);
        return res.status(400).send();
      }
      res.status(200).json(results)
    })
  } catch(err){
    console.log(err);
    return res.status(500).send();
  }
})

// Show Patient Profile
app.get('/department/:hospitalName', (req, res) => {
  const hospitalName = req.params.hospitalName;
  dbConnection.query(
    'SELECT * FROM department WHERE hospitalName = ?', [hospitalName],
    (err, results, fields) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        res.json(results);
      }
    }
  );
});

app.get('/doctor/:departmentName', (req, res) => {
  const departmentName = req.params.departmentName;
  dbConnection.query(
    'SELECT * FROM doctor WHERE departmentName = ?', [departmentName],
    (err, results, fields) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        res.json(results);
      }
    }
  );
});

app.get('/appointment/:patientId', (req, res) => {
  const patientId = req.params.patientId;
  dbConnection.query(
    'SELECT a.*, d.doctorName, d.doctorPicture ' +
    'FROM appointment a ' +
    'JOIN doctor d ON a.doctorId = d.doctorId ' +
    'WHERE a.patientId = ?', [patientId],
    (err, results, fields) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        res.json(results);
      }
    }
  );
});

app.get('/appointmentDoctor/:doctorId', (req, res) => {
  const doctorId = req.params.doctorId;
  dbConnection.query(
    'SELECT a.*, p.*' +
    'FROM appointment a ' +
    'JOIN patient p ON a.patientId = p.patientId ' +
    'WHERE a.doctorId = ? AND a.appointmentStatus = "Pending"', [doctorId], // Fixed typo in column name and added quotes around "Pending"
    (err, results, fields) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        res.json(results);
      }
    }
  );
});

app.get('/appointment/doctor/:doctorId', (req, res) => {
  const doctorId = req.params.doctorId;

  dbConnection.query(`
    SELECT 
      a.*, 
      d.doctorName, 
      d.doctorPicture,
      p.patientFirstname AS patientFirstname,
      p.patientLastname AS patientLastname,
      p.patientId AS patientId
    FROM appointment a
    JOIN doctor d ON a.doctorId = d.doctorId
    LEFT JOIN patient p ON a.patientId = p.patientId
    WHERE a.doctorId = ? AND a.appointmentStatus = 'Pending';`, [doctorId],
    (err, results, fields) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error', details: err.message });
      } else {
        if (results.length > 0) {
          res.json(results);
        } else {
          res.status(404).json({ error: 'No appointment details found' });
        }
      }
    }
  );
});


app.get('/appointment/:patientId/:appointmentDate', (req, res) => {
  const patientId = req.params.patientId;
  const appointmentDate = req.params.appointmentDate;

  dbConnection.query(
    'SELECT a.*, d.doctorName, d.doctorPicture ' +
    'FROM appointment a ' +
    'JOIN doctor d ON a.doctorId = d.doctorId ' +
    'WHERE a.patientId = ? AND a.appointmentDate = ?', [patientId, appointmentDate],
    (err, results, fields) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        res.json(results);
      }
    }
  );
});

app.get('/check-email/:patientEmail', (req, res) => {
  const email = req.params.patientEmail;

  dbConnection.query(
    'SELECT * FROM patient WHERE patientEmail = ?',
    [email],
    (err, results, fields) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        if (results.length > 0) {
          // Email already exists
          res.json({ exists: true });
        } else {
          // Email doesn't exist
          res.json({ exists: false });
        }
      }
    }
  );
});

// READ Patient Details for a Specific Appointment
app.get('/patient-details/:appointmentId', (req, res) => {
  const appointmentId = req.params.appointmentId;

  dbConnection.query('SELECT patientId FROM appointment WHERE appointmentId = ?', [appointmentId], (err, results, fields) => {
    if (err) {
      console.log(err);
      return res.status(400).send();
    }

    if (results.length === 0) {
      return res.status(404).json({ error: 'Appointment not found' });
    }

    const patientId = results[0].patientId;

    dbConnection.query('SELECT * FROM patient WHERE patientId = ?', [patientId], (err, results, fields) => {
      if (err) {
        console.error('Error querying patient details:', err);
        return res.status(500).json({ error: 'Internal Server Error' });
      }
      res.status(200).json(results);
    });
  });
});

//READ single users from db
app.get("/read/single/:patientEmail", async (req, res) => {
  const email = req.params.patientEmail;
  try{
    dbConnection.query("SELECT * FROM patient WHERE patientEmail = ?", [email], (err, results, fields) => {
      if (err) {
        console.log(err);
        return res.status(400).send();
      }
      res.status(200).json(results)
    })
  } catch(err){
    console.log(err);
    return res.status(500).send();
  }
})

app.get('/appointment-details/:appointmentId', (req, res) => {
  const appointmentId = req.params.appointmentId;
  dbConnection.query('SELECT * FROM appointment WHERE appointmentId = ?', [appointmentId], (err, results, fields) => {
    if (err) {
      console.log(err);
      return res.status(400).send();
    }
    res.status(200).json(results);
  });
});

app.get('/appointmentDoctor/:doctorId/:appointmentDate', (req, res) => {
  const doctorId = req.params.doctorId;
  const appointmentDate = req.params.appointmentDate;

  dbConnection.query(
    'SELECT a.*, p.* ' +
    'FROM appointment a ' +
    'JOIN patient p ON a.patientId = p.patientId ' + // Corrected the table name from 'paitent' to 'patient'
    'WHERE a.doctorId = ? AND a.appointmentDate = ?', [doctorId, appointmentDate],
    (err, results, fields) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        res.json(results);
      }
    }
  );
});


//UPDATE data
app.patch("/reschedule/:appointmentId", async(req,res) => {
  const appointmentId = req.params.appointmentId;
  const { newDate, newTime } = req.body;

  try{
    dbConnection.query("UPDATE appointment SET appointmentDate = ?, appointmentTime = ? WHERE appointmentId = ?",
    [newDate, newTime, appointmentId], (err, results, fields) => {
      if (err) {
        console.log(err);
        return res.status(400).send();
      }
      res.status(200).json({message: "Appointment rescheduled successfully"})
    })
  } catch(err){
    console.log(err);
    return res.status(500).send();
  }
})

// UPDATE patientEditProfile

//DELETE APPOINTMENT
app.delete("/cancelAppointment/:appointmentId", async(req,res) => {
  const appointmentId = req.params.appointmentId;

  try{
    dbConnection.query("DELETE FROM appointment WHERE appointmentId = ?", [appointmentId], (err, results, fields) => {
      if (err) {
        console.log(err);
        return res.status(400).send();
      }
      if (results.affectedRows === 0){
        return res.status(404).json({message:"No appointment with that appointment id"})
      }
      res.status(200).json({message: "Appointment deleted successfully"})
    })
  } catch(err){
    console.log(err);
    return res.status(500).send();
  }
})

app.put('/end-meeting/:appointmentId', (req, res) => {
  const appointmentId = req.params.appointmentId;

  // Assuming you have a database and a query to update the appointment status
  dbConnection.query('UPDATE appointment SET appointmentStatus = ? WHERE appointmentId = ?', ['Success', appointmentId], (err, results, fields) => {
    if (err) {
      console.log(err);
      return res.status(400).send();
    }
    res.status(200).send('Meeting ended successfully');
  });
});

app.listen(port, () => {
  console.log('Server is running...');
});