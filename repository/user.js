var db = require('../database/db');

module.exports = {
    all: () => {
        return db.load('select * from NguoiDung');
    },
    add: entity => {
        return db.add('NguoiDung', entity);
    },
    singleByUserName: userName => {
        return db.load(`select * from NguoiDung where UserName = '${userName}'`);
    },
}