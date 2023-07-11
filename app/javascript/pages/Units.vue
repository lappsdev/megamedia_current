<template>
  <div>
    <v-dialog v-if="selectedItem" v-model="dialog.edit" width="800">
      <v-card>
        <v-toolbar flat color="primary" dark>
          <v-btn icon>
            <v-icon>mdi-bank</v-icon>
          </v-btn>
          <v-toolbar-title>Unidade {{ selectedItem.name }}</v-toolbar-title>
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
        <v-card-title> Cadastrar nova unidade</v-card-title>
        <v-card-text>
          <Form @success="finishedRegister"></Form>
        </v-card-text>
      </v-card>
    </v-dialog>
    <v-card flat>
      <v-toolbar>
        <v-btn icon>
          <v-icon color="primary">mdi-bank</v-icon>
        </v-btn>
        <v-toolbar-title color="primary"> Unidades </v-toolbar-title>

        <v-spacer></v-spacer>

        <v-btn color="primary" icon @click="dialog.create = true">
          <v-icon>mdi-plus</v-icon>
        </v-btn>
      </v-toolbar>
      <v-card-text>
        <Table
          :scope="scope"
          ref="table"
          @click:row="onTableRowClick"
          :headers="tableHeaders"
          sort-by="name"
        >
          <template v-slot:item.name="{ item }">
            <v-avatar size="36px">
              <v-icon>mdi-bank</v-icon>
            </v-avatar>
            {{ item.name }}
          </template>
        </Table>
      </v-card-text>
    </v-card>
  </div>
</template>
<script>
import Table from "components/Table";
import Form from "components/Units/Form";
import { Unit } from "models/unit.model";
import { Attachment } from "models/attachment.model";

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
    ],
  }),
  methods: {
    onTableRowClick(item) {
      this.$router.push({ name: "unit", params: { id: item.id } });
    },
    openDialog(item, options) {
      this.selectedItem = item;
      this.dialog.edit = true;
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
      return Unit;
    },
  },
  created() {
   
  },
};
</script>