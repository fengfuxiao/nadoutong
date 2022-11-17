<!-- @format -->

<template>
  <div class="personal-message">
    <el-card>
      <!-- 展示用户信息开始 -->
      <div v-if="!isEditPersonal">
        <div class="avatar">
          <el-avatar
            src="https://s1.ax1x.com/2022/10/19/xstyHP.jpg"
            :size="100"
          ></el-avatar>
        </div>
        <el-form ref="userInfo" :model="userInfo" label-width="80px">
          <el-form-item label="用户名">
            <span>{{ userInfo.username }}</span>
          </el-form-item>
          <el-form-item label="昵称">
            <span>{{ userInfo.nickname }}</span>
          </el-form-item>
          <el-form-item label="年龄">
            <span>{{ userInfo.age }}</span>
          </el-form-item>
          <el-form-item label="性别">
            <span>{{ userInfo.gender }}</span>
            <!-- <el-input v-model="userInfo.gender"></el-input> -->
          </el-form-item>
          <el-form-item label="地址">
            <span>{{ userInfo.address }}</span>
          </el-form-item>
          <el-form-item label="角色">
            <span>{{
              (userInfo.r_id = userInfo.r_id === 1 ? "普通用户" : "管理员")
            }}</span>
          </el-form-item>
        </el-form>
      </div>
      <!-- 展示用户信息结束 -->
      <!-- 编辑用户信息开始 -->
      <div v-else>
        <el-upload
          class="avatar-uploader"
          action
          :http-request="handleUpload"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
        >
          <img v-if="imageUrl" :src="imageUrl" class="upavatar" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </div>
      <!-- 编辑用户信息结束 -->
      <el-button type="primary" @click="isEditPersonal = !isEditPersonal">{{
        isEditPersonal ? "保存" : "编辑用户信息"
      }}</el-button>
    </el-card>
  </div>
</template>

<script>
import { mapState } from "vuex";
import { put, signatureUrl, getFileNameUUID } from '@/utils/upload.js'

export default {
  name: "PersonalMessage",
  data() {
    return {
      userInfo: {},
      // 是否编辑用户信息
      isEditPersonal: false,
      imageUrl: "",
    };
  },
  methods: {
    /**
     * 自定义上传方法
     */
     handleUpload(option) {
      // 获取文件的后缀名
      let objName = getFileNameUUID()
      var obj = option.file.name
      // console.log("fileName=", option)
      var index = obj.lastIndexOf(".");
      obj = obj.substring(index,obj.length);
      // console.log("obj=", obj)
      // 生成的文件名，保留文件后缀名，进行拼接
      objName = getFileNameUUID() + obj
      // console.log("objName=", objName)
      // 调用 ali-oss 中的方法,flieName是存放的文件夹名称，可自己定义
      put(`flieName/${objName}`, option.file).then(res => {
        console.log(res)
        // 上传成功之后，转换真实的地址
        signatureUrl(`flieName/${objName}`).then(res => {
            console.log("success=", res)
        })
      })
    },
    // 上传成功调用函数
    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    // 上传之前调用函数
    beforeAvatarUpload(file) {
      const isJPG = file.type === "image/jpeg";
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error("上传头像图片只能是 JPG 格式!");
      }
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 2MB!");
      }
      return isJPG && isLt2M;
    },
  },
  computed: {
    ...mapState("userModule", ["user"]),
  },
  mounted() {
    this.userInfo = this.user;
    // console.log("user=", this.user);
    // console.log("userinfo=", this.userInfo);
  },
};
</script>

<style lang="less">
.personal-message .el-card__body {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.personal-message .avatar {
  display: inline-block;
}
.personal-message {
  .el-form {
    .el-form-item__label {
      // margin-right: 2px;
    }
  }
}
// 编辑用户
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.upavatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
