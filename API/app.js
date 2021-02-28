const cors = require("cors");
const express = require("express");
const bp = require("body-parser");
const passport = require('passport');
const { connect } = require("mongoose");
const { success, error } = require("consola");


// Bring in app constats
const { DB, PORT } = require("./config");

// Initialize appplication
const app = express();

// Middlewares 
// app.use(cors);
app.use(bp.json());
app.use(passport.initialize());
app.use('/files', express.static("files"));

require('./middlewares/passport')(passport);

// Swagger
const swaggerUi = require('swagger-ui-express'),
swaggerDocument = require('./swagger.json');

// User Route Middleware
const users = require("./routes/users");
const productRoutes = require("./routes/produts");
const cartRoutes = require('./routes/cart');
const postRoutes = require('./routes/post');
const reporterRoutes = require('./routes/reporter');
const mediaRoutes = require('./routes/media');

app.use('/api/users', users);
app.use("/api/product", productRoutes);
app.use("/api/cart", cartRoutes);
app.use("/api/post", postRoutes);
app.use("/api/reporter", reporterRoutes);
app.use("/api/media", mediaRoutes);




app.get('/',(req,res)=>{
    res.send('welocome');
});


const startApp = async () => {
  try {
      // Connet to database
    await connect(DB, {
      useFindAndModify: true,
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    success({
      message: `Successfully connected to database \n${DB}`,
      badge: true,
    });

    // swagger 
    app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));


    // Litesning on port 5000
    app.listen(PORT, () =>
      success({ message: `Server started on PORT ${PORT}`, badge: true })
    );
  } catch (err) {
    error({ message: `Falied to connected database ${err}`, badge: true });
    startApp();
  };
  
};

startApp();
