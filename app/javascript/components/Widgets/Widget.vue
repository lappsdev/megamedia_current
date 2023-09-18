<template>
  <div style="width: 100%; height: 100%">
    <template v-if="editable">
      <v-dialog v-if="editDialog" v-model="editDialog" width="800">
        <v-card>
          <v-toolbar flat color="primary" dark>
            <v-toolbar-title>Editando Widget</v-toolbar-title>
            <v-spacer></v-spacer>
          </v-toolbar>
          <v-card-text>
            <Form :model="instance" :schema="instance.getFormSchema()"
              :save="() => instance.save({ with: ['attachment', 'department'] })" @success="edited"></Form>
          </v-card-text>
        </v-card>
      </v-dialog>

      <v-speed-dial v-model="fab" top right absolute direction="bottom">
        <template v-slot:activator>
          <v-btn v-model="fab" small color="blue darken-2" dark fab>
            <v-icon v-if="fab"> mdi-close </v-icon>
            <v-icon v-else> mdi-dots-vertical </v-icon>
          </v-btn>
        </template>
        <v-btn fab dark small color="green" @click="editDialog = true">
          <v-icon>mdi-pencil</v-icon>
        </v-btn>
        <v-btn fab dark small color="red" @click="deleteWidget">
          <v-icon>mdi-delete</v-icon>
        </v-btn>
      </v-speed-dial>
    </template>
    <component :is="componentFile" :widget="instance" :running="!editable"></component>
  </div>
</template>

<script>
import Form from "components/Form";

export default {
  components: {
    Form,
  },
  props: {
    instance: { required: true },
    editable: { type: Boolean, default: false },
  },
  data() {
    return {
      fab: false,
      editDialog: false,
    };
  },
  methods: {
    edited() {
      this.editDialog = false;
      this.$emit("edited", this.instance);
    },
    deleteWidget() {
      this.$dialog
        .confirm({
          title: "Atenção",
          text: "Deseja realmente excluir esta widget?",
        })
        .then((res) => {
          console.log(res);
          if (res) {
            this.instance.destroy().then((success) => {
              if (success) {
                this.$emit("deleted", this.instance);
              } else {
                this.$toast.error("Erro ao deletar widget");
              }
            });
          }
        });
    },
  },
  computed: {
    componentFile() {
      return () => import(`components/Widgets/${this.instance.type}`);
    },
  },
};
</script>

<style></style>