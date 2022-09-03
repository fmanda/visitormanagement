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
      <el-menu-item index="1">Sedang Berlangsung</el-menu-item>
      <el-menu-item index="2">Semua Kunjungan</el-menu-item>

    </el-menu>

    <br/>

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

          <el-descriptions class="margin-top" title="" :column="1" size="" border>
            <!-- <template slot="extra">
              <el-button type="primary" size="small">Operation</el-button>
            </template> -->
            <!-- <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-user"></i>
                Menemui Karyawan
              </template>
              kooriookami
            </el-descriptions-item> -->
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-mobile-phone"></i>
                No. Telepon
              </template>
              18100000000
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                Instansi
              </template>
              <el-tag>School</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label-class-name="my-label">
              <template slot="label">
                <i class="el-icon-office-building"></i>
                Alamaat
              </template>
              No.1188, Wuzhong Avenue, Wuzhong District, Suzhou, Jiangsu Province
            </el-descriptions-item>
            <el-descriptions-item label-class-name="my-label">
              <template slot="label">
                <i class="el-icon-tickets"></i>
                Keperluan
              </template>
              Diskusi bisnis
            </el-descriptions-item>
          </el-descriptions>

          <!-- <el-timeline>
          <el-timeline-item :timestamp="props.row.entrydate">Masuk</el-timeline-item>
          <el-timeline-item :timestamp="props.row.exitdate">Keluar</el-timeline-item>
        </el-timeline> -->
        </template>
      </el-table-column>
      <el-table-column label="Pengunjung" prop="visitorname" sortable/>
      <!-- <el-table-column label="Keperluan" prop="reason" /> -->
      <el-table-column label="Menemui" prop="person_to_meet" sortable/>
      <el-table-column label="Department" prop="deptname" sortable/>
      <el-table-column
        label="Masuk"
        width="180"
        sortable
        >
        <template slot-scope="scope">
          <!-- <i class="el-icon-time"></i> -->
          <span style="margin-left: 10px">{{ scope.row.entrydate }}</span>
        </template>
      </el-table-column>

      <!-- <el-table-column
        label="Keluar"
        width="180">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.exitdate }}</span>
        </template>
      </el-table-column> -->

      <el-table-column
        label="Durasi"
        width="120"
        sortable
        >
        <template slot-scope="scope">
          <i class="el-icon-time"></i>
          <span style="margin-left: 10px">1:24:30</span>
        </template>
      </el-table-column>

      <el-table-column
        fixed="right"
        label="Status"
        width="100">
        <template slot-scope="scope">
          <el-button  type="text"
            size="small">
            Keluar
          </el-button>
        </template>
      </el-table-column>

      <!-- <el-table-column label="Keluar" prop="exitdate" /> -->
      <!-- <el-table-column
        align="right"
      > -->
        <!-- <template slot="header" slot-scope="scope">
          <el-input
            v-model="search"
            size="mini"
            placeholder="Type to search"
          />
          <span hidden>{{ scope.row }}</span>
        </template> -->
        <!-- <template slot-scope="scope">
          </el-steps>
          <el-button
            size="mini"
            @click="handleEdit(scope.$index, scope.row)"
          >Edit</el-button> -->
          <!-- <el-button
            v-if="scope.row.deptcode !== null "
            size="mini"
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
          >Delete</el-button> -->
        <!-- </template> -->
      <!-- </el-table-column> -->
    </el-table>
    <br>
    <el-button type="success" icon="el-icon-plus" @click.native.prevent="handleNew()">Add Department</el-button>

    <el-dialog :title="dialogData.caption" :visible.sync="dialogVisible" width="800px">
      <el-row>
        <el-col :span="12">
          <el-descriptions class="margin-top" title="" :column="1" border>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-user"></i>
                Nama
              </template>
              <el-input v-model="dialogData.Nama"></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-office-building"></i>
                Instansi
              </template>
              <el-input v-model="dialogData.Nama"></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-mobile-phone"></i>
                Telepon
              </template>
              <el-input v-model="dialogData.Nama"></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                Alamat
              </template>
              <el-input
                type="textarea"
                :rows="2"
                v-model="dialogData.Alamat">
              </el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-mobile-phone"></i>
                No. Identitas
              </template>
              <el-input v-model="dialogData.Nama"></el-input>
            </el-descriptions-item>
          </el-descriptions>
        </el-col>

        <el-col :span="12">
          <el-descriptions class="margin-top" title="" :column="1" border>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-user"></i>
                Department
              </template>
              <el-input v-model="dialogData.Nama"></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-office-building"></i>
                Karyawan
              </template>
              <el-input v-model="dialogData.Nama"></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                Keperluan
              </template>
              <el-input v-model="dialogData.Alamat">
              </el-input>
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-mobile-phone"></i>
                Foto
              </template>
              <el-skeleton style="width: 140px">
                <template slot="template">
                  <el-skeleton-item variant="image" style="width: 180px; height: 131px;" />
                  <!-- <div style="padding: 14px;">
                    <el-skeleton-item variant="p" style="width: 50%" />
                    <div
                      style="display: flex; align-items: center; justify-items: space-between;"
                    >
                      <el-skeleton-item variant="text" style="margin-right: 16px;" />
                      <el-skeleton-item variant="text" style="width: 30%;" />
                    </div>
                  </div> -->
                </template>
              </el-skeleton>
            </el-descriptions-item>

          </el-descriptions>
        </el-col>
      </el-row>



        <!-- <el-row>
          <el-col :span="12">
            <el-form ref="form" :model="dialogData" label-width="150px" >
              <el-form-item label="Nama Pengunjung">
                <el-input v-model="dialogData.deptcode" />
              </el-form-item>
              <el-form-item label="Dari Instansi">
                <el-input v-model="dialogData.deptname" />
              </el-form-item>
              <el-form-item label="Alamat Pengunjung">
                <el-input
                  type="textarea"
                  :rows="2"
                  v-model="dialogData.Alamat">
                </el-input>
              </el-form-item>
              <el-form-item label="No. Telepon">
              <el-input v-model="dialogData.deptname" />
              </el-form-item>
            </el-form>
          </el-col>
          <el-col :span="12">
            <el-form ref="form" :model="dialogData" label-width="150px" >
              <el-form-item label="Department">
                <el-input v-model="dialogData.deptname" />
              </el-form-item>
              <el-form-item label="Menemui">
                <el-input v-model="dialogData.deptname" />
              </el-form-item>
              <el-form-item label="Keperluan">
                <el-input
                  type="textarea"
                  :rows="2"
                  v-model="dialogData.Alamat">
                </el-input>
              </el-form-item>
            </el-form>
          </el-col>
        </el-row> -->

      <!-- </el-card> -->

      <span slot="footer" class="dialog-footer">
        <el-button style ="float: left;" @click.native.prevent="saveData()">Ambil Foto</el-button>
        <el-button type="primary" @click.native.prevent="saveData()">Simpan</el-button>
        <el-button type="danger" @click="dialogVisible = false">Batal</el-button>
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
    background: #304156;
  }
  .el-form-item {
    margin-bottom: 15px;
  }
</style>

<style>
   .el-descriptions-item__cell.el-descriptions-item__label.is-bordered-label {
     width: 120px;
   }
</style>
