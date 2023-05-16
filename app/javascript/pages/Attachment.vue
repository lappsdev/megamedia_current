<template>
  <div v-if="attachment">
    <v-card>
      <v-toolbar color="cyan" dark flat>
        <v-toolbar-title
          >Midia {{ attachment.name }} #{{ attachment.id }}</v-toolbar-title
        >

        <v-spacer></v-spacer>

        <v-btn icon>
          <v-icon>mdi-magnify</v-icon>
        </v-btn>

        <v-btn icon>
          <v-icon>mdi-dots-vertical</v-icon>
        </v-btn>

        <template v-slot:extension>
          <v-tabs v-model="tab" align-with-title>
            <v-tabs-slider color="yellow"></v-tabs-slider>

            <v-tab key="general">Geral</v-tab>
            <v-tab key="medias">Usos de mídia</v-tab>
            <v-tab key="scheduler">Agendamentos</v-tab>
          </v-tabs>
        </template>
      </v-toolbar>

      <v-tabs-items v-model="tab">
        <v-tab-item key="general">
          <v-card flat>
            <v-card-text>
              <v-list subheader three-line>
                <v-subheader>Geral</v-subheader>
                <v-edit-dialog :return-value.sync="attachment.name">
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>Descrição da mídia</v-list-item-title>
                      <v-list-item-subtitle>
                        {{ attachment.name || "N/A" }}
                      </v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                  <template v-slot:input>
                    <v-text-field
                      v-model="attachment.name"
                      label="Editar"
                      single-line
                      counter
                    ></v-text-field>
                  </template>
                </v-edit-dialog>

                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>Tipo de mídia</v-list-item-title>
                    <v-list-item-subtitle>{{
                      attachment.attachType
                    }}</v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item>
              </v-list>

              <v-divider></v-divider>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <v-tab-item key="medias">
          <v-dialog v-model="newMediaDialog" max-width="600px">
            <template v-slot:activator="{ on, attrs }">
              <v-btn color="primary" dark v-bind="attrs" v-on="on">
                Open Dialog
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                <span class="headline">Novo uso de mídia</span>
              </v-card-title>
              <v-card-text>
                <v-container>
                  <v-select
                    :items="['0-17', '18-29', '30-54', '54+']"
                    label="Age*"
                    required
                  ></v-select>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="blue darken-1"
                  text
                  @click="newMediaDialog = false"
                >
                  Close
                </v-btn>
                <v-btn
                  color="blue darken-1"
                  text
                  @click="newMediaDialog = false"
                >
                  Save
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-tab-item>

        <v-tab-item key="scheduler">
          <v-subheader>Agendamentos</v-subheader>

          <v-dialog
            ref="menuStartedAt"
            v-model="menuStartedAt"
            :return-value.sync="attachment.scheduler.startedAt"
            width="290px"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-list-item v-bind="attrs" v-on="on">
                <v-list-item-content>
                  <v-list-item-title>Inicio do período</v-list-item-title>
                  <v-list-item-subtitle>
                    {{ attachment.scheduler.startedAt || "N/A" }}
                  </v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </template>
            <v-date-picker
              v-model="attachment.scheduler.startedAt"
              @input="$refs.menuStartedAt.save(attachment.scheduler.startedAt)"
            ></v-date-picker>
          </v-dialog>

          <v-dialog
            ref="menuFinishedAt"
            v-model="menuFinishedAt"
            :return-value.sync="attachment.scheduler.finishedAt"
            width="290px"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-list-item v-bind="attrs" v-on="on">
                <v-list-item-content>
                  <v-list-item-title>Término do período</v-list-item-title>
                  <v-list-item-subtitle>
                    {{ attachment.scheduler.finishedAt || "N/A" }}
                  </v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </template>
            <v-date-picker
              v-model="attachment.scheduler.finishedAt"
              @input="
                $refs.menuFinishedAt.save(attachment.scheduler.finishedAt)
              "
            ></v-date-picker>
          </v-dialog>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
import { Attachment } from "models/attachment.model";
export default {
  props: {
    id: { required: true },
  },
  data() {
    return {
      attachment: null,
      tab: null,
      menuStartedAt: null,
      menuFinishedAt: null,
      newMediaDialog: null,
    };
  },
  computed: {
    weekDays() {
      [];
    },
  },
  methods: {
    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${month}/${day}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;

      const [month, day, year] = date.split("/");
      return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
    },
  },
  created() {
    Attachment.includes(["scheduler"])
      .find(this.id)
      .then((response) => {
        this.attachment = response.data;
      });
  },
};
</script>

<style>
</style>