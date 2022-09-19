<template>
  <div class="app-container">
    <el-alert v-if="errormsg != '' "
      :title="errormsg"
      type="error"
      show-icon>
    </el-alert>

    <el-menu
      :default-active="activeMenu"
      class="el-menu-demo"
      mode="horizontal"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b"
      @select="handleSelect"
      style = "margin-bottom: 10px"
    >
      <el-menu-item index="1"><i class="el-icon-user"></i>Akan Berlangsung</el-menu-item>
      <el-menu-item index="2"><i class="el-icon-date"></i>Semua Appointment</el-menu-item>
    </el-menu>

    <div v-if= "activeMenu >= '2' ">
      <el-date-picker
        v-model="filterperiod"
        type="daterange"
        align="right"
        unlink-panels
        range-separator="To"
        start-placeholder="Start date"
        end-placeholder="End date"
        :picker-options="pickerOptions"
        @change="handleChangePeriod"
        style = "float: right; margin-left: 10px; margin-bottom: 10px;"
        >
      </el-date-picker>
      <el-input
        placeholder="Pencarian"
        prefix-icon="el-icon-search"
        style = "width: 400px; float: right; margin-bottom: 10px;"
        @change="handleChangeInputSearch"
        clearable
        v-model="filtertxt">
      </el-input>
    </div>

    <el-table
      :v-loading="listLoading"
      :data="data"
      style="width: 100%"
    >
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-descriptions class="margin-top" style="margin-left: 50px;" title="" :column="1" size="" border>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-mobile-phone"></i>
                No. Telepon
              </template>
              {{props.row.phone}}
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                Instansi
              </template>
              {{props.row.company}}
            </el-descriptions-item>
            <el-descriptions-item label-class-name="my-label">
              <template slot="label">
                <i class="el-icon-office-building"></i>
                Alamaat
              </template>
              {{props.row.address}}
            </el-descriptions-item>
            <el-descriptions-item label-class-name="my-label">
              <template slot="label">
                <i class="el-icon-tickets"></i>
                Keperluan
              </template>
              {{props.row.reason}}
            </el-descriptions-item>
          </el-descriptions>
        </template>
      </el-table-column>
      <el-table-column label="Pengunjung" prop="visitorname" sortable/>
      <el-table-column label="Menemui" prop="person_to_meet" sortable/>
      <el-table-column label="Department" prop="deptname" sortable/>
      <el-table-column label="Keperluan" prop="reason" sortable/>

      <el-table-column
        label="Jadwal Bertemu"
        width="180"
        sortable
        >
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.planningdate }}</span>
        </template>
      </el-table-column>

      <el-table-column
        fixed="right"
        label="Status"
        width="140">
        <template slot-scope="scope">
          <el-button-group>
            <el-button plain icon="el-icon-edit-outline" size="small" type="primary" @click="handleEdit(scope.$index, scope.row)"></el-button>
            <el-button plain size="small" type="danger" @click="handleDelete(scope.$index, scope.row)" >Hapus</el-button>
          </el-button-group>
        </template>
      </el-table-column>

    </el-table>
    <br>

    <el-button type="primary" icon="el-icon-plus" @click.native.prevent="handleNew()">Buat Appointment</el-button>


    <el-dialog :title="dialogData.caption" :visible.sync="dialogVisible" width="900px" :before-close="handleCloseDlg"
      class="inputdialog" top="5vh"
    >
      <el-row>
        <el-col :span="11" >
          <el-descriptions class="margin-top" title="" :column="1" border>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-user"></i>
                Nama
              </template>
              <!-- <el-input v-model="dialogData.visitor.visitorname"></el-input> -->
              <el-select
                v-model="selectedVisitorID"
                filterable
                remote
                reserve-keyword
                allow-create
                default-first-option
                placeholder="Input / Pilih Nama Pengunjung"
                :remote-method="searchVisitor"
                :loading="visitorLoading"
                style = "width:100%"
              >
                <el-option
                  v-for="visitor in visitors"
                  :key="visitor.id"
                  :label="visitor.visitorname"
                  :value="visitor.id">
                </el-option>

              </el-select>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-office-building"></i>
                Instansi
              </template>
              <el-input v-model="dialogData.visitor.company"></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-mobile-phone"></i>
                Telepon
              </template>
              <el-input v-model="dialogData.visitor.phone"></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                Alamat
              </template>
              <el-input
                type="textarea"
                :rows="2"
                v-model="dialogData.visitor.address">
              </el-input>
            </el-descriptions-item>
            <!-- <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-mobile-phone"></i>
                Identitas
              </template>
              <el-input v-model="dialogData.visitor.idcardno"></el-input>
            </el-descriptions-item> -->
          </el-descriptions>
        </el-col>

        <el-col :span="13" style="padding-left:10px">
          <el-descriptions class="margin-top" title="" :column="1" border>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-user"></i>
                Department
              </template>
              <el-select v-model="param_department_id" placeholder="Select Department" style="width:85%">
                <el-option
                  v-for="dept in depts"
                  :key="dept.id"
                  :label="dept.deptname"
                  :value="dept.id"
                >
                  <span style="float: left">{{ dept.deptname }}</span>
                  <!-- <span style="float: right; color: #8492a6; font-size: 13px">{{ dept.deptcode }}</span> -->
                </el-option>
              </el-select>

              <!-- <el-input v-model="dialogData.department.deptname"></el-input> -->
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-office-building"></i>
                Karyawan
              </template>

              <el-select
                v-model="dialogData.person_to_meet"
                filterable
                remote
                reserve-keyword
                allow-create
                default-first-option
                placeholder="Input / Pilih Karyawan"
                :remote-method="searchEmployee"
                :loading="employeeLoading"
                style = "width:85%"
              >
                <el-option
                  v-for="employee in listemployee"
                  :key="employee.employeename"
                  :label="employee.employeename"
                  :value="employee.employeename">
                </el-option>

              </el-select>

              <!-- <el-input v-model="dialogData.person_to_meet"></el-input> -->
            </el-descriptions-item>

            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                Tanggal
              </template>
              <el-date-picker
                v-model="dialogData.planningdate"
                type="datetime"
                placeholder="Pilih tanggal"
                :picker-options="pickerOptions"
                default-time="10:00:00">
              </el-date-picker>
            </el-descriptions-item>

            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                Keperluan
              </template>
              <el-input
                type="textarea"
                :rows="2"
                v-model="dialogData.reason">
              </el-input>
            </el-descriptions-item>
          </el-descriptions>
        </el-col>
      </el-row>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" :disabled = "dialogReadOnly" @click.native.prevent="saveData()">Simpan</el-button>
        <el-button type="danger"  @click="dialogVisible = false">Batal</el-button>
      </span>
    </el-dialog>


  </div>
</template>

<script>
import { getAppointment, getListAppointment, postAppointment, getOngoingAppointment, searchAppointment, deleteAppointment } from '@/api/appointment'
import { getListVisitor, getVisitor } from '@/api/visitor'
import { getListDept, getListEmployee } from '@/api/department'
// import { WebCam } from 'vue-web-cam';
import { find, head } from 'lodash';

export default {
  components: {
    // WebCam
  },
  data() {
    return {
      data: [],
      listLoading: true,
      search: '',
      errormsg: '',
      dialogData: {
        caption: '',
        visitor: {
        },
        department: {
        }
      },
      dialogVisible: false,
      activeMenu: '1',
      param_department_id: null,
      depts: [],
      visitors: [],
      visitorLoading: false,
      listemployee: [],
      employeeLoading: false,
      selectedVisitorID: null,
      filterperiod: [
        new Date().getTime() -(3600 * 1000 * 24 * 30),
        new Date().getTime() +(3600 * 1000 * 24 * 30)
      ],
      pickerOptions: {
        shortcuts: [{
          text: 'Hari Ini',
          onClick(picker) {
            const date = new Date();
            date.setHours(10, 0, 0);
            picker.$emit('pick', date);
          }
        }, {
          text: 'Besuk',
          onClick(picker) {
            const date = new Date();
            date.setHours(10, 0, 0);
            date.setTime(date.getTime() + 3600 * 1000 * 24);
            picker.$emit('pick', date);
          }
        }, {
          text: 'Lusa',
          onClick(picker) {
            const date = new Date();
            date.setHours(10, 0, 0);
            date.setTime(date.getTime() + 3600 * 1000 * 24 * 2);
            picker.$emit('pick', date);
          }
        }]
      },
      filtertxt: '',
      dialogReadOnly: false
      // isdocument: false
    }
  },
  created() {
    // this.fetchData()
    // this.setTimers();
  },
  beforeDestroy() {
  },
  computed: {
  },
  watch: {
    selectedVisitorID: function() {
      if (!this.selectedVisitorID) {
        this.dialogData.visitor = {
          id: 0
        }
        this.dialogData.visitor_id = 0;
        return;
      }
      // not number
      if (isNaN(this.selectedVisitorID)) {
        this.dialogData.visitor = {
          id: 0,
          visitorname: this.selectedVisitorID
        }
        this.dialogData.visitor_id = 0;
        return;
      }

      // fetch api
      if (this.dialogData.visitor_id) {
        if (this.dialogData.visitor_id === this.selectedVisitorID) {
          return
        }
      }

      if (this.selectedVisitorID) {
        getVisitor(this.selectedVisitorID).then(response => {
          this.dialogData.visitor = response.data;
          this.dialogData.visitor_id = this.selectedVisitorID;
        });
      }
    }

  },
  beforeMount() {
    this.fetchData();
    this.initForm();
  },
  methods: {
    initForm() {
      getListDept().then(response => {
        this.depts = response.data;
      });
      // console.log(this.depts);
    },
    fetchData() {
      this.listLoading = true;

      if (this.activeMenu === '1'){
        getOngoingAppointment().then(response => {
          this.data = response.data;
          this.listLoading = false;
        })
      }
      else{
        if (!this.filterperiod) return
        const dt1 = this.filterperiod[0];
        const dt2 = this.filterperiod[1];

        if (!dt1 ||  !dt2) return;
        searchAppointment(dt1, dt2, this.filtertxt).then(response => {
          this.data = response.data;
          this.listLoading = false;
          // this.setTimers();
        })
      }
    },
    searchVisitor(query) {
      if (query !== '') {
        this.visitorloading = true;

        getListVisitor(query).then(response => {
          this.visitors = response.data;
          this.visitorLoading = false;
        })
      } else {
        this.visitors = [];
      }
    },
    searchEmployee(query) {
      if (query !== '') {
        this.employeeLoading = true;
        getListEmployee(this.param_department_id, query).then(response => {
          this.listemployee = response.data;
          this.employeeLoading = false;
        })
      } else {
        this.visitors = [];
      }
    },
    showDialog(id) {
      this.selectedVisitorID = null;
      this.$set(this, 'selectedVisitorID', null);

      getAppointment(id).then(response => {
        this.dialogData = response.data;
        this.visitors = [];
        this.listemployee = [];
        // console.log(this.dialogData);
        if (id === 0) {
          this.param_department_id = null;
          this.dialogData = {
            caption: 'Tambah Data Appointment',
            visitor: {},
            department: {}
          };
        } else {
          this.dialogData.caption = 'Edit Data Appointment';
          if (this.dialogData.department) {
            this.param_department_id = this.dialogData.department.id
          }
          this.visitors.push(this.dialogData.visitor);
          this.selectedVisitorID = this.dialogData.visitor_id;
        }
        this.dialogVisible = true;
      })
    },
    handleCloseDlg(done) {
      this.$confirm('Anda yakin menutup form ini?')
        .then(_ => {
          done();
        })
        .catch(_ => {});
    },
    handleEdit(index, row, viewonly = false) {
      this.dialogReadOnly = viewonly;
      this.showDialog(row.id);
    },
    handleDelete(index, row, viewonly = false) {
      var vm = this;
      this.$confirm('Anda yakin menghapus appointment ini i?')
      .then(_ => {
        deleteAppointment(row.id).then(response => {
          vm.fetchData();
        });
      })
      .catch(_ => {});
    },
    handleNew() {
      this.showDialog(0);
    },
    handleSelect(key, keyPath) {
      this.activeMenu  = key;
      this.fetchData()
    },
    getVisitorNameFromAR(id){
      for (var v in this.data){
        if (v.id === id){
          return v;
        }
      }
      return null
    },
    saveData() {
      var vm = this;
      this.dialogData.dept_id = this.param_department_id;

      if (!vm.dialogData.planningdate){
        vm.$message({
          message: 'Tanggal Belum Dipilih',
          type: 'error',
          duration: 5 * 1000
        });
        return;
      }

      //overwrite datetime

      postAppointment(this.dialogData, this.img1, this.img2).then(response => {
        vm.$message({
          type: 'success',
          message: 'Data Berhasil Disimpan'
        });
        vm.dialogVisible = false;
        vm.fetchData();
      })
    },
    handleChangePeriod(){
      // console.log(this.filterperiod);
      this.fetchData()
    },
    handleChangeInputSearch(){
      // console.log('handleChangeInputSearch');
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
    background: #304156;
  }
  .el-form-item {
    margin-bottom: 15px;
  }
</style>

<style>
   .el-descriptions-item__cell.el-descriptions-item__label.is-bordered-label {
     width: 120px;
     color: #909399;
     background: #fafafa;
   }

   .inputdialog .el-dialog__header{
     display: none;
   }

   .inputdialog .el_dialog{
     margin-top: 5vh;
   }
</style>
