const {getAdminInfo} = require('../../PersistenceLayer/AdminInfoDAO')

const GetAdminInfo = async (req, res) =>{
    let data = await getAdminInfo(req.query.id);
    return res.status(200).json(data[0]);
}

module.exports = {GetAdminInfo}