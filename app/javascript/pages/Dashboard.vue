<template>
  <v-row>
    <v-col cols="3">
      <widget
        @click.native="teste"
        icon="devices"
        title="TTT"
        subTitle="Dispositivos cadastrados"
        color="#00b297"
      ></widget>
    </v-col>
    <v-col cols="3">
      <widget
        icon="mdi-nintendo-switch"
        title="3 online / 0 offline"
        subTitle="Dispositivos operantes"
        color="#dc3545"
      ></widget>
    </v-col>
    <v-col cols="3">
      <widget
        icon="mdi-play-network-outline"
        title="a0"
        subTitle="Mídias sendo exibidas"
        color="#0866C6"
      ></widget>
    </v-col>
    <v-col cols="3">
      <widget
        icon="mdi-cash-refund"
        title="a0"
        subTitle="Mídias patrocinadas em exibição"
        color="#1D2939"
      ></widget>
    </v-col>
  </v-row>
</template>

<script>
import Widget from "components/DashboardCard";
import { Device } from "models/device.model";

export default {
  components: {
    Widget,
  },
  data() {
    return {
      deviceCount: 0,
      deviceOnline: 0,
      deviceOffline: 0,
    };
  },
  computed: {},
  methods: {
    teste() {
      this.$router.push("/admin/devices");
    },
  },
  created() {
    Device.stats({ total: "count" })
      .all()
      .then((response) => {
        this.deviceCount = response.meta.stats.total.count;
      });
  },
};
</script>

<style>
</style>