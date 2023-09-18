<template>
  <div>
    <v-dialog v-if="newWidget.dialog" v-model="newWidget.dialog" width="800">
      <v-card>
        <v-toolbar flat color="primary" dark>
          <v-toolbar-title>Nova widget {{ newWidget.type.name }}</v-toolbar-title>
          <v-spacer></v-spacer>
        </v-toolbar>
        <v-card-text>
          <Form :model="newWidget.type.model" :schema="newWidget.type.model.getFormSchema()" :save="() =>
            newWidget.type.model.save({
              with: ['screen', 'attachment', 'department'],
            })
            " @success="onCreatedWidget"></Form>
        </v-card-text>
      </v-card>
    </v-dialog>

    <v-card flat v-if="screen">
      <v-toolbar>
        <v-btn icon>
          <v-icon color="primary">mdi-monitor</v-icon>
        </v-btn>
        <v-toolbar-title color="primary">
          <v-edit-dialog @save="saveScreen" :return-value.sync="screen.name">Tela {{ screen.name }}
            <v-icon>mdi-pencil</v-icon>
            <template v-slot:input>
              <v-text-field v-model="screen.name" label="Editar" single-line counter></v-text-field>
            </template>
          </v-edit-dialog>
        </v-toolbar-title>

        <v-spacer></v-spacer>

        <v-menu transition="slide-x-transition" bottom right>
          <template v-slot:activator="{ on, attrs }">
            <v-btn color="primary" v-bind="attrs" v-on="on">
              <v-icon>mdi-plus</v-icon>
              Adicionar Widget
            </v-btn>
          </template>

          <v-list>
            <v-list-item v-for="(type, i) in widgetTypes" :key="i" @click="createWidget(type)">
              <v-list-item-title>{{ type.name }}</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
        <v-btn @click="deleteScreen" color="error" dark>
          <v-icon>mdi-trash-can-outline</v-icon>
          Excluir Tela
        </v-btn>
      </v-toolbar>
      <v-card-text>
        <grid-layout :layout.sync="layout" :col-num="12" :row-height="50" :is-draggable="true" :is-resizable="true"
          :is-mirrored="false" :vertical-compact="false" :maxRows="12" :margin="[5, 5]" :use-css-transforms="true">
          <grid-item v-for="item in layout" :x="item.x" :y="item.y" :w="item.w" :h="item.h" :i="item.i" :key="item.i"
            @moved="movedEvent" @resized="resizedEvent">
            <div class="grid-item-container">
              <WidgetComponent :instance="item.instance" editable @edited="onEditedWidget(item.instance)"
                @deleted="onDeletedWidget(item.instance)"></WidgetComponent>
            </div>
          </grid-item>
        </grid-layout>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import {
  Screen,
  Widget,
  Attachment,
  ProductTableWidget,
  ImageWidget,
  VideoWidget,
  PriceCheckerWidget,
  QueueCallerWidget,
  PasswordCallerWidget,
} from "models";

import { GridLayout, GridItem } from "vue-grid-layout";
import WidgetComponent from "components/Widgets/Widget";
import Form from "components/Form";

export default {
  props: ["id"],
  components: {
    GridLayout,
    GridItem,
    WidgetComponent,
    Form,
  },
  data() {
    return {
      screen: null,
      layout: [],
      newWidget: { dialog: false, type: null },
    };
  },
  computed: {
    channelName() {
      return `screen_${this.id}`;
    },
    widgetTypes() {
      return [
        {
          name: "Widget de imagem",
          model: new ImageWidget(this.newWidgetData),
        },
        {
          name: "Widget de video",
          model: new VideoWidget(this.newWidgetData),
        },
        {
          name: "Widget consulta preço",
          model: new PriceCheckerWidget({
            ...this.newWidgetData,
            x: 0,
            y: 0,
            width: 12,
            height: 12,
          }),
        },
        {
          name: "Widget chama-fila",
          model: new QueueCallerWidget({
            ...this.newWidgetData,
            x: 0,
            y: 0,
            width: 12,
            height: 12,
          }),
        },
        {
          name: "Widget Tabela de preços",
          model: new ProductTableWidget(this.newWidgetData),
        },
        {
          name: "Widget Chama-senha",
          model: new PasswordCallerWidget(this.newWidgetData),
        },
      ];
    },
    newWidgetData() {
      return {
        screen: this.screen,
        x: (this.layout.length * 2) % 12,
        y: this.layout.length + 12,
        width: 2,
        height: 2,
      };
    },
  },
  methods: {
    deleteScreen() {
      this.$dialog
        .confirm({
          title: "Atenção",
          text: "Deseja realmente excluir esta tela?",
        })
        .then((res) => {
          console.log(res);
          if (res) {
            this.screen.destroy().then((success) => {
              if (success) {
                this.$toast.success("Tela excluída com sucesso!");

                this.$router.push("/admin/screens");
              } else {
                this.$toast.error("Erro ao deletar tela");
              }
            });
          }
        });
    },
    saveScreen() {
      this.screen.save().then((success) => {
        if (success) {
          this.$toast.success("Tela atualizada com sucesso!");
        }
      });
    },
    onChange() {
      this.$cable.perform({
        channel: "ScreenChannel",
        action: "edit",
        data: {
          content: "SUCOOO",
        },
      });
    },
    movedEvent: function (i, newX, newY) {
      let widget = this.screen.widgets.find((e) => e.id == i);
      widget.x = newX;
      widget.y = newY;
      this.screen.save({ with: "widgets" }).then((success) => {
        if (success) {
          this.onChange();
        }
      });
    },
    resizedEvent: function (i, height, width, newHPx, newWPx) {
      let widget = this.screen.widgets.find((e) => e.id == i);
      widget.width = width;
      widget.height = height;
      this.screen.save({ with: "widgets" }).then((success) => {
        if (success) {
          this.onChange();
        }
      });
    },
    onCreatedWidget(widget) {
      this.newWidget.dialog = false;
      this.$toast.success("Widget criada com sucesso!");
      this.onChange();
      this.reloadScreen();
    },

    onEditedWidget() {
      this.$toast.success("Widget editada com sucesso!");
      this.onChange();
      this.reloadScreen();
    },

    onDeletedWidget() {
      this.$toast.success("Widget deletada com sucesso!");
      this.onChange();
      this.reloadScreen();
    },

    createWidget(type) {
      this.newWidget.type = type;
      this.newWidget.dialog = true;
    },
    reloadScreen() {
      this.layout = [];
      this.screen = null;
      Screen.includes(["widgets.screen", "widgets.attachment", "device", "widgets.department"])
        .find(this.id)
        .then((response) => {
          this.screen = response.data;
          this.layout = this.screen.widgets.map((e) => ({
            w: e.width,
            h: e.height,
            x: e.x,
            y: e.y,
            i: e.id,
            instance: e,
            static: false,
          }));
        });
    },
  },

  created() {
    this.reloadScreen();
  },
  channels: {
    ScreenChannel: {
      connected() {
        console.log("Websocket conectado.");
      },
      rejected() { },
      received(data) {
        console.log(data);
      },
      disconnected() { },
    },
  },

  async mounted() {
    this.$cable.subscribe({
      channel: "ScreenChannel",
      id: this.id,
    });
  },
};
</script>

<style scoped>
.grid-item-container {
  font-size: 24px;
  text-align: center;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  height: auto;
  width: 100%;
}
</style>