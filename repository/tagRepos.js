var db = require('../database/db');

module.exports = {
    tag:(tag)=>{
        return db.load(`select * from nhan where TenTag = '${tag}'`)
    },
    pageByTag: (tag, limit, offset) => {
        return db.load(`call HienThiBaiVietTheoNhan('${tag}',${limit},${offset});`);
    },
    countByTag: tag => {
        return db.load(`select count(*) as total from nhan where tentag = '${tag}'`);
    },
}