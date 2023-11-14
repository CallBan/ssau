let express = require('express');
let app = express();
   
app.use(express.static(__dirname + '/public'));
app.use("/", (req, res) => {
    res.redirect("index.html")
});

app.listen(3000);