<template>
  <div class="app-container">
    <el-menu
      :default-active="activeMenu"
      class="el-menu-demo"
      mode="horizontal"
      @select="handleSelect"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b">
      <el-menu-item index="1">Sedang Berjalan</el-menu-item>
      <el-menu-item index="2">Berdasarkan Tanggal</el-menu-item>
    </el-menu>

    <el-table
      :v-loading="listLoading"
      :data="data.filter(data => !search || data.deptname.toLowerCase().includes(search.toLowerCase()))"
      style="width: 100%"
    >


      <el-table-column type="expand">
        <template slot-scope="props">
          <!-- <el-card class="box-card">
            <p>State: {{ props.row.state }}</p>
            <p>City: {{ props.row.city }}</p>
            <p>Address: {{ props.row.address }}</p>
            <p>Zip: {{ props.row.zip }}</p>

          </el-card> -->

          <el-descriptions class="margin-top" title="With border" :column="3" size="" border>
            <template slot="extra">
              <el-button type="primary" size="small">Operation</el-button>
            </template>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-user"></i>
                Username
              </template>
              kooriookami
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-mobile-phone"></i>
                Telephone
              </template>
              18100000000
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                Place
              </template>
              Suzhou
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-tickets"></i>
                Remarks
              </template>
              <el-tag size="small">School</el-tag>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-office-building"></i>
                Address
              </template>
              No.1188, Wuzhong Avenue, Wuzhong District, Suzhou, Jiangsu Province
            </el-descriptions-item>
          </el-descriptions>

          <el-timeline reverse="false">
          <el-timeline-item :timestamp="props.row.entrydate">Masuk</el-timeline-item>
          <el-timeline-item :timestamp="props.row.exitdate">Keluar</el-timeline-item>
        </el-timeline>
        </template>
      </el-table-column>
      <el-table-column label="Pengunjung" prop="visitorname" />
      <el-table-column label="Keperluan" prop="reason" />
      <el-table-column label="Department|Karyawan" prop="department" />
      <el-table-column label="Masuk" prop="entrydate" />
      <el-table-column label="Keluar" prop="exitdate" />
      <el-table-column
        align="right"
      >
        <template slot="header" slot-scope="scope">
          <el-input
            v-model="search"
            size="mini"
            placeholder="Type to search"
          />
          <span hidden>{{ scope.row }}</span>
        </template>
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="handleEdit(scope.$index, scope.row)"
          >Edit</el-button>
          <!-- <el-button
            v-if="scope.row.deptcode !== null "
            size="mini"
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
          >Delete</el-button> -->
        </template>
      </el-table-column>
    </el-table>
    <br>
    <el-button type="success" icon="el-icon-plus" @click.native.prevent="handleNew()">Add Department</el-button>

    <el-dialog :title="dialogData.caption" :visible.sync="dialogVisible" width="600px">
      <el-form ref="form" :model="dialogData" label-width="120px">
        <el-form-item label="Dept Code">
          <el-input v-model="dialogData.deptcode" />
        </el-form-item>
        <el-form-item label="Dept Name">
          <el-input v-model="dialogData.deptname" />
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click.native.prevent="saveData()">Update</el-button>
        <el-button @click="dialogVisible = false">Cancel</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script>
import { getVisit, getListVisit, postVisit } from '@/api/visit'

export default {
  data() {
    return {
      data: [],
      listLoading: true,
      search: '',
      dialogData: {
        caption: ''
      },
      dialogVisible: false,
      activeMenu : "1"
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.listLoading = true
      getListVisit().then(response => {
        this.data = response.data;
        this.listLoading = false
      })
    },
    showDialog(id) {
      getVisit(id).then(response => {
        this.dialogData = response.data;
        if (id === 0) {
          this.dialogData = { caption: '' }
        } else {
          this.dialogData.caption = 'Edit Department';
        }

        this.dialogVisible = true;
      })
    },
    handleEdit(index, row) {
      this.showDialog(row.id);
      // this.$router.push({ name: 'update_department', params: { id: row.id }})
    },
    handleNew() {
      this.showDialog(0);
      // this.$router.push({ path: '/master/update_department' })
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },
    saveData() {
      var vm = this;
      postVisit(this.dialogData).then(response => {
        vm.$message({
          type: 'success',
          message: 'Data Berhasil Disimpan'
        });
        vm.dialogVisible = false;
        vm.fetchData();
      })
    }
  }
}
</script>

<style scoped>
  .el-table >>> .cell {
    word-break: break-word;
    white-space: pre-wrap;
  }

  .el-table >>> thead {
    color: rgb(191, 203, 217);
    font-weight: 500;
    background: #304156;
  }

  .el-table >>> th {
    /* color: rgb(191, 203, 217); */
    background: #304156;
  }
</style>
