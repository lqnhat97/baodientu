var db = require('../../database/db');

module.exports = {
    dsBaiVietByManager:id => {
        return db.load(`call XemBaiVietDoMinhQuanLy(${id});`)
    },
    dsBaiVietAllByManager:id => {
        return db.load(`call XemBaiVietDoMinhDaXuLy(${id});`)
    }
}