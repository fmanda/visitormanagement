<template>
  <div class="dashboard-container">
    <el-row>
      <el-col :span="8" class="card-container">
        <el-card class="box-card">
          <el-badge :value="12" class="item">
            <el-tag type="primary">Pengunjung</el-tag>
          </el-badge>
        </el-card>
      </el-col>
      <el-col :span="8" class="card-container">
        <el-card class="box-card">
          <el-badge :value="12" class="item">
            <el-tag type="warning">Dokumen</el-tag>
          </el-badge>
        </el-card>
      </el-col>
      <el-col :span="8" class="card-container" >
        <el-card class="box-card">
          <el-badge :value="12" class="item">
            <el-tag type="success">Appointment</el-tag>
          </el-badge>
        </el-card>
      </el-col>
    </el-row>

  </div>
</template>

<script>

export default {
  name: 'dashboard'
}
</script>

<style lang="scss" scoped>
  .dashboard {
    &-container {
      margin: 30px;
    }
    &-text {
      font-size: 30px;
      line-height: 46px;
    }
  }

  .box-card {
    width: 100%;
  }

  .card-container {
    padding: 10px;
  }
</style>
