<template>
  <div>
    <v-dialog v-if="selectedItem" v-model="dialog.edit" width="800">
      <v-card>
        <v-toolbar flat color="primary" dark>
          <v-btn icon>
            <v-icon>mdi-animation-play</v-icon>
          </v-btn>
          <v-toolbar-title>Mídia #{{ selectedItem.id }}</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn @click="deleteItem(selectedItem)">Deletar</v-btn>
        </v-toolbar>
        <v-card-text>
          <Form :model="selectedItem" @success="onEdits"></Form>
        </v-card-text>
      </v-card>
    </v-dialog>
    <DropzoneInput @uploaded="refreshTable"></DropzoneInput>

    <v-card class="mt-5" flat>
      <v-toolbar>
        <v-btn icon>
          <v-icon color="primary">mdi-animation-play</v-icon>
        </v-btn>
        <v-toolbar-title color="primary"> Mídias </v-toolbar-title>

        <v-spacer></v-spacer>
      </v-toolbar>
      <v-card-text>
        <Table
          @click:row="onRowClick"
          :scope="scope"
          ref="table"
          sort-by="name"
          :headers="tableHeaders"
        >
          <template v-slot:item.preview="{ item }">
            <template v-if="item.attachType == 'image'">
              <img :src="item.file" width="100px" height="100px" />
            </template>
            <template v-if="item.attachType == 'video'">
              <video
                style="background: black; object-fit: fill"
                width="100px"
                height="100px"
                muted="muted"
              >
                "
                <source :src="item.file" type="video/mp4" />
              </video>
            </template>
          </template>
          <template v-slot:item.expiredAt="{ item }">
            {{ item.expiredAt | moment("DD/MM/YYYY HH:mm") }}
            <v-chip
              v-if="item.expired"
              small
              class="ma-2"
              color="red"
              text-color="white"
            >
              Expirado
            </v-chip>
          </template>

          <template v-slot:item.name="{ item }">
            <v-avatar size="36px">
              <v-icon>mdi-mdi-animation-play</v-icon>
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
import Form from "components/Attachments/Form";
import { Attachment } from "models/attachment.model";
import DropzoneInput from "components/DropzoneInput";
export default {
  components: {
    Table,
    Form,
    DropzoneInput,
  },
  data: () => ({
    dialog: { create: false, edit: false },
    selectedItem: null,
    tableHeaders: [
      {
        text: "Preview",
        value: "preview",
        align: "start",
      },
      {
        text: "Nome",
        value: "name",
        align: "start",
      },
      {
        text: "Descrição",
        value: "description",
        align: "start",
      },
      {
        text: "Expira em",
        value: "expiredAt",
        align: "start",
      },
    ],
  }),
  methods: {
    onRowClick(item, options) {
      this.$router.push({ name: "attachment", params: { id: item.id } });
      //  this.selectedItem = item;
      // this.dialog.edit = true;
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
      return Attachment.includes(["medias"]);
    },
  },
};
</script>