module.exports = (req, res, next) => {
    res.statusCode = 404;
    res.render('error404',{
        layout:'main.hbs'
    });
};