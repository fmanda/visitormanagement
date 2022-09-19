<template>
  <div class="app-container">
    <el-table
      :v-loading="listLoading"
      :data= "data"
      style="width: 100%"
    >
      <el-table-column label="Nama Karyawan" prop="employeename" />
      <el-table-column label="Department" prop="deptname" />
      <el-table-column
        align="right"
      >
        <template slot="header" slot-scope="scope">
          <el-input
            v-model="search"
            size="mini"
            @change="handleChangeInputSearch"
            placeholder="Type to search"
          />
          <span hidden>{{ scope.row }}</span>
        </template>
        <!-- <template slot-scope="scope">
          <el-button
            size="mini"
            @click="handleEdit(scope.$index, scope.row)"
          >View</el-button>
        </template> -->
      </el-table-column>
    </el-table>
    <br>
  </div>
</template>

<script>
import { getDepartment, getListDept, postDepartment, getAllEmployee } from '@/api/department'

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
      this.listLoading = true;
      console.log(this.search);
      getAllEmployee(this.search).then(response => {
        this.data = response.data;
        this.listLoading = false
      })
    },
    handleChangeInputSearch(){
      this.fetchData()
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
