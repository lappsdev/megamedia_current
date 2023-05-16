<template>
  <div>
    <v-dialog v-if="selectedItem" v-model="dialog.edit" width="800">
      <v-card>
        <v-toolbar flat color="primary" dark>
          <v-btn icon>
            <v-icon>mdi-devices</v-icon>
          </v-btn>
          <v-toolbar-title>Equipamento {{ selectedItem.name }}</v-toolbar-title>
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
        <v-card-title> Cadastrar novo equipamento</v-card-title>
        <v-card-text>
          <Form @success="finishedRegister"></Form>
        </v-card-text>
      </v-card>
    </v-dialog>
    <v-card flat>
      <v-toolbar>
        <v-btn icon>
          <v-icon color="primary">mdi-devices</v-icon>
        </v-btn>
        <v-toolbar-title color="primary"> Equipamentos </v-toolbar-title>

        <v-spacer></v-spacer>

        <v-btn color="primary" icon @click="dialog.create = true">
          <v-icon>mdi-plus</v-icon>
        </v-btn>
      </v-toolbar>
      <v-card-text>
        <Table
          :scope="scope"
          ref="table"
          show-group-by
          @click:row="openDialog"
          :headers="tableHeaders"
          sort-by="name"
        >
          <template v-slot:group.header="{ group, remove }">
            {{ group }}
            <v-btn small @click="remove">Desagrupar</v-btn>
          </template>
          <template v-slot:item.name="{ item }">
            <v-avatar size="36px">
              <v-icon>mdi-devices</v-icon>
            </v-avatar>
            {{ item.name }}
          </template>

          <template v-slot:item.unit.name="{ item }">
            <v-avatar size="36px">
              <v-icon>mdi-bank</v-icon>
            </v-avatar>
            {{ item.unit.name }}
          </template>
          <template v-slot:item.state="{ item }">
            <div class="text-center">
              <v-menu offset-y>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn color="primary" dark v-bind="attrs" v-on="on">
                    Ver ações
                  </v-btn>
                </template>
                <v-list>
                  <v-list-item @click="setHomepage(item)">
                    <v-list-item-title
                      >Definr página inicial (SSH)</v-list-item-title
                    >
                  </v-list-item>
                  <v-list-item @click="reboot(item)">
                    <v-list-item-title>Reiniciar</v-list-item-title>
                  </v-list-item>
                  <v-list-item @click="executeCommand(item)">
                    <v-list-item-title
                      >Executar comando (SSH)</v-list-item-title
                    >
                  </v-list-item>
                </v-list>
              </v-menu>
            </div>
          </template>
        </Table>
      </v-card-text>
    </v-card>
  </div>
</template>
<script>
import Table from "components/Table";
import Form from "components/Devices/Form";
import { Device, SshCommand } from "models";
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
        groupable: false,
      },
      {
        text: "IP",
        value: "ip",
        align: "start",
        groupable: false,
      },
      {
        text: "Observações",
        value: "notes",
        align: "start",
        groupable: false,
      },
      {
        text: "Unidade",
        value: "unit.name",
        align: "start",
        groupable: true,
      },
      {
        text: "Ações",
        value: "state",
        align: "start",
        groupable: false,
      },
    ],
  }),
  methods: {
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
    reboot(device) {
      let ssh = new SshCommand({
        command: "sudo reboot",
        sshRunner: device,
      });
      ssh
        .save({ with: "sshRunner" })
        .then((success) => {
          this.$dialog.info({
            text: ssh.output,
            title: "Executado com sucesso",
          });
        })
        .catch((err) => {
          this.$dialog.info({
            text: ssh.output,
            title: "Executado com sucesso",
          });
        });
    },
    executeCommand(device) {
      this.$dialog
        .prompt({
          text: "Insira o comando a ser executado",
          title: "Executar comando",
        })
        .then((result) => {
          if (result) {
            this.$dialog
              .info({
                text: "Executando...",
                waitForResult: false,
                actions: {},
                close: false,
              })
              .then((dialog) => {
                let ssh = new SshCommand({
                  command: result,
                  sshRunner: device,
                });
                ssh
                  .save({ with: "sshRunner" })
                  .then((success) => {
                    if (success) {
                      this.$dialog.info({
                        text: ssh.output,
                        title: "Executado com sucesso",
                      });
                    } else {
                      console.log();
                    }
                    dialog.close();
                  })
                  .catch((err) => {
                    dialog.close();
                  });
              });
          }
        });
    },
    setHomepage(device) {
      this.$dialog
        .prompt({
          text: "Digite a URL da página",
          title: "Alterar homepage",
        })
        .then((result) => {
          if (result) {
            this.$dialog
              .info({
                text: "Executando...",
                waitForResult: false,
                actions: {},
                close: false,
              })
              .then((dialog) => {
                let ssh = new SshCommand({
                  command: result,
                  sshRunner: device,
                });
                ssh.setHomePageCommand(result);
                ssh
                  .save({ with: "sshRunner" })
                  .then((success) => {
                    if (success) {
                      this.$dialog.info({
                        text: ssh.output,
                        title: "Executado com sucesso",
                      });
                    } else {
                      console.log();
                    }
                    dialog.close();
                  })
                  .catch((err) => {
                    dialog.close();
                  });
              });
          }
        });
    },

    refreshTable() {
      this.$refs.table.reload();
    },
  },
  computed: {
    scope() {
      return Device.includes("unit");
    },
  },
};
</script>