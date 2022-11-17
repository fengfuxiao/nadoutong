import { v4 as uuidv4 } from "uuid"
// 引入ali-oss
let OSS = require('ali-oss')

/**
 *  [accessKeyId] {String}：通过阿里云控制台创建的AccessKey。
 *  [accessKeySecret] {String}：通过阿里云控制台创建的AccessSecret。
 *  [bucket] {String}：通过控制台或PutBucket创建的bucket。
 *  [region] {String}：bucket所在的区域， 默认oss-cn-hangzhou。
 */
let client = new OSS({
    region: 'oss-cn-hangzhou',
    secure: true,  // secure: 配合region使用，如果指定了secure为true，则使用HTTPS访问  
    accessKeyId: 'LTAI5tJeSCH3AaQZFDcifMQ1',
    accessKeySecret: 'GBcJEs57R5hMQcAgPUMHQSWKLk1cpw',
    bucket: 'ndt2022-11-11'
})

/** 
*  上传文件，大小不能超过5GB 
* @param {string} ObjName OSS的储存路径和文件名字 
* @param {string} fileUrl 本地文件 
* @retruns Promise 
*/
export const put = async (ObjName, fileUrl) => {
    try {
        let result = await client.put(`${ObjName}`, fileUrl)
        // ObjName为文件名字,可以只写名字，就直接储存在 bucket 的根路径，如需放在文件夹下面直接在文件名前面加上文件夹名称    
        return result
    } catch (e) {
        console.log(e)
    }
}

// 上传成功之后，转换真实的地址
export const signatureUrl = async (ObjName) => {
    try {
        let result = await client.signatureUrl(`${ObjName}`)
        return result
    } catch (e) {
        console.log(e)
    }
}

/** 
* 生成随机文件名称 
* 规则八位随机字符，加下划线连接时间戳 
*/
export const getFileNameUUID = () => {
    // function rx() {
    //     return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
    // }
    // return `${+new Date()}_${rx()}${rx()}`
    return uuidv4()
}