<template>
  <div class="dashboard-container">
    <el-row>

      <el-col :span="12" class="card-container">
        <el-card class="box-card">
          <!-- <el-badge :value="12" class="item"> -->
            <el-tag type="success">Kunjungan Per Dept</el-tag>
          <!-- </el-badge> -->

          <DxPieChart
            id="pie"
            :data-source="datavisitdept"
            type="doughnut"
            title=""
            palette="Soft Pastel"
            class="dashboard-chart"
          >
            <DxSeries argument-field="deptname" value-field="visit">
              <DxLabel:visible="true">
                <DxConnector :visible="true"/>
              </DxLabel>
            </DxSeries>
            <!-- <DxExport :enabled="true"/> -->
            <DxLegend
              :margin="0"
              horizontal-alignment="right"
              vertical-alignment="top"
            />
            <DxTooltip
              :enabled="true"
              :customize-tooltip="customizeTooltip"
            >
              <DxFormat/>
            </DxTooltip>
          </DxPieChart>

        </el-card>
      </el-col>

      <el-col :span="12" class="card-container">
        <el-card class="box-card">
          <el-badge :value="totalVisit" class="item">
            <el-tag type="primary">Pengunjung 1 Minggu Terakhir</el-tag>
          </el-badge>
          <DxChart
            :data-source="datavisitWeek"
            class="dashboard-chart"
          >
            <DxSeries
              :bar-padding="0.1"
              type="bar"
              argument-field="dayname"
              value-field="visit"
              name="Visit"
              color="#ffaa66"
            />

            <DxSeries
              :bar-padding="0.1"
              type="bar"
              argument-field="dayname"
              value-field="appointment"
              name="appointment"
              color="#1E90FF"
            />

            <DxSeries
              :bar-padding="0.1"
              type="bar"
              argument-field="dayname"
              value-field="document"
              name="document"
              color="#8FBC8F"
            />

            <DxLegend orientation="horizontal" position="outside"/>
          </DxChart>
        </el-card>
      </el-col>


      <!-- <el-col :span="8" class="card-container" >
        <el-card class="box-card">
          <el-badge :value="12" class="item">
            <el-tag type="success">Appointment</el-tag>
          </el-badge>

          </DxChart>
        </el-card>
      </el-col> -->
    </el-row>

    <el-card class="box-card">
      <DxChart
        :data-source="datavisitMonth"
        class="dashboard-chart-month"
      >
        <DxSeries
          :bar-padding="0.1"
          type="bar"
          argument-field="tanggal"
          value-field="visit"
          name="Visit"
          color="#ffaa66"
        />

        <DxSeries
          :bar-padding="0.1"
          type="bar"
          argument-field="tanggal"
          value-field="appointment"
          name="appointment"
          color="#1E90FF"
        />

        <DxSeries
          :bar-padding="0.1"
          type="bar"
          argument-field="tanggal"
          value-field="document"
          name="document"
          color="#8FBC8F"
        />

        <DxLegend orientation="horizontal" :visible="false"/>
      </DxChart>
    </el-card>

  </div>
</template>

<script>

import { DxChart, DxSeries, DxLegend } from 'devextreme-vue/chart';
import DxPieChart, {
  DxTooltip,
  DxFormat,
  DxLabel,
  DxConnector,
  DxExport
} from 'devextreme-vue/pie-chart';

import { getVisitDashboardWeek, getVisitDashboardMonth, getVisitDeptDashboard } from '@/api/dashboard'


export default {
  name: 'dashboard',
  components: {
    DxChart,
    DxSeries,
    DxPieChart,
    DxFormat,
    DxLabel,
    DxConnector,
    DxExport,
    DxTooltip,
    DxLegend
  },
  data() {
    return {
      datavisitWeek: [],
      datavisitMonth: [],
      datavisitdept: [],
      totalVisit: 0
    }
  },
  beforeMount() {
    this.fetchData();
  },
  methods: {
    fetchData() {
      getVisitDashboardWeek().then(response => {
        this.datavisitWeek = response.data;
        this.totalVisit = 0;

        for (var _visit of this.datavisitWeek){
          this.totalVisit = this.totalVisit + _visit.visit + _visit.document;
        }
      });

      getVisitDashboardMonth().then(response => {
        this.datavisitMonth = response.data;
      });

      getVisitDeptDashboard().then(response => {
        this.datavisitdept = response.data;
      });
    },
    customizeTooltip({ valueText, percent }) {
      return {
        text: `${valueText} - ${(percent * 100).toFixed(2)}%`,
      };
    },
  }

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
    padding: 5px;
  }

  .dashboard-chart {
    height: 300px;
  }

  .dashboard-chart-month {
    height: 200px;
  }
</style>
