<template>
  <div class="app-container">
    <el-table
      :v-loading="listLoading"
      :data="data.filter(data => !search || data.deptname.toLowerCase().includes(search.toLowerCase()))"
      style="width: 100%"
    >
      <el-table-column label="Dept Code" prop="deptcode" width="100px" />
      <el-table-column label="Dept Name" prop="deptname" />
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
import { getDepartment, getListDept, postDepartment } from '@/api/department'

export default {
  data() {
    return {
      data: [],
      listLoading: true,
      search: '',
      dialogData: {
        caption: ''
      },
      dialogVisible: false
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.listLoading = true
      getListDept().then(response => {
        this.data = response.data;
        this.listLoading = false
      })
    },
    showDialog(id) {
      getDepartment(id).then(response => {
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
    saveData() {
      var vm = this;
      postDepartment(this.dialogData).then(response => {
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
