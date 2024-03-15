let mongoose = require('mongoose');
let LawfirmSchema = new mongoose.Schema(
    {   cid:{ type:Number,required:true },
        fname:{ type:String,required:true },
        lname:{ type:String,required:true },
        address:{ type:String,required:true },
        pno:{ type:Number,required:true },
        assistancetype:{ type:String,required:true },
        appdate:{ type:String,required:true },
        apptime:{ type:String,required:true },
        description:{ type:String }
    }
)
module.exports = mongoose.model('Lawfirm',LawfirmSchema);
