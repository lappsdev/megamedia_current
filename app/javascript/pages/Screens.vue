<template>
  <div>
    <v-dialog v-if="selectedItem" v-model="dialog.edit" width="800">
      <v-card>
        <v-toolbar flat color="primary" dark>
          <v-btn icon>
            <v-icon>mdi-devices</v-icon>
          </v-btn>
          <v-toolbar-title>Tela {{ selectedItem.name }}</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn @click="deleteItem(selectedItem)">Deletar</v-btn>
        </v-toolbar>
        <v-card-text>
          <Form :model="selectedItem" @success="onEdits"></Form>
        </v-card-text>
      </v-card>
    </v-dialog>
    <v-dialog v-model="dialog.create" width="800">
      <v-card>
        <v-card-title> Cadastrar nova tela</v-card-title>
        <v-card-text>
          <Form @success="finishedRegister"></Form>
        </v-card-text>
      </v-card>
    </v-dialog>
    <v-card flat>
      <v-toolbar>
        <v-btn icon>
          <v-icon color="primary">mdi-monitor</v-icon>
        </v-btn>
        <v-toolbar-title color="primary"> Telas </v-toolbar-title>

        <v-spacer></v-spacer>

        <v-btn color="primary" icon @click="dialog.create = true">
          <v-icon>mdi-plus</v-icon>
        </v-btn>
      </v-toolbar>
      <v-card-text>
        <Table
          :scope="scope"
          ref="table"
          @click:row="editScreen"
          :headers="tableHeaders"
          sort-by="name"
        >
          <template v-slot:item.name="{ item }">
            <v-avatar size="36px">
              <v-icon>mdi-monitor</v-icon>
            </v-avatar>
            {{ item.name }}
          </template>

          <template v-slot:item.device="{ item }">
            <div v-if="item.device">
              <v-avatar size="36px">
                <v-icon>mdi-devices</v-icon>
              </v-avatar>
              {{ item.device.name }}
            </div>
          </template>
        </Table>
      </v-card-text>
    </v-card>
  </div>
</template>
<script>
import Table from "components/Table";
import Form from "components/Screens/Form";
import { Screen } from "models/screen.model";
export default {
  components: {
    Table,
    Form,
  },
  data: () => ({
    dialog: { create: false, edit: false },
    selectedItem: null,
    tableHeaders: [
      {
        text: "Nome",
        value: "name",
        align: "start",
      },
      {
        text: "Equipamento",
        value: "device",
        align: "start",
      },
    ],
  }),
  methods: {
    editScreen(item, options) {
      this.$router.push("/admin/screenEdit/" + item.id);
    },
    finishedRegister(item) {
      this.refreshTable();

      this.$toast.success(`Finalizado o cadastro!`);
      this.dialog.create = false;
    },
    onEdits(unit) {
      this.refreshTable();
      this.$toast.success("Editada com sucesso!");
      this.dialog.edit = false;
    },
    deleteItem(item) {
      item.destroy().then((success) => {
        if (success) {
          this.refreshTable();
          this.$toast.success("Deletada com sucesso!");
          this.dialog.edit = false;
        }
      });
    },
    refreshTable() {
      this.$refs.table.reload();
    },
  },
  computed: {
    scope() {
      return Screen.includes("device");
    },
  },
};
</script>