module.exports = (req, res, next) => {
    if (req.session.passport.hasOwnProperty('user')) {
        next();
    } else {
        res.redirect(`./login?retUrl=${req.originalUrl}`);
    }
}