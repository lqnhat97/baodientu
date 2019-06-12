var db = require('../../database/db');

exports.loadChuyenMuc=()=>{
    let sql = `select * from chuyenmuc;`;
    return db.load(sql);
};

exports.themBaiViet=(data)=>{
    let sql = `call ThemBaiViet(null,N'${data.tieuDe}','${data.chuyenMuc}',NOW(),'${data.img}',N'${data.noiDung}',N'${data.xemTruoc}',1,1)`;
    return db.load(sql);
}