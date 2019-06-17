var categoryRepos = require('../repository/main');

module.exports = (req, res, next) => {
    categoryRepos.loadChuyenMuc().then(rows => {
        let data = rows.filter(value => {
            return value.ChuyenMucCha != null;
        });
        let data1 = rows.filter(value => {
            return value.ChuyenMucCha == null;
        });
        for (const [index, value] of data1.entries()) {
            //console.log(value);
            let dataChild = data.filter(cm => {
                return cm.ChuyenMucCha == value.IDChuyenMuc;
            });
            if (dataChild.length != 0) {
                data1[index].ChuyenMucCon = []
                data1[index].ChuyenMucCon.push(dataChild)
                data1[index].ChuyenMucCon = data1[index].ChuyenMucCon[0];
            }
        }
        res.locals._category = data1;
        if (req.session.passport.hasOwnProperty('user'))
            res.locals._user = req.session;
        next();
    })
}