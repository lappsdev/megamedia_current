<template>
  <v-carousel
    cycle
    height="820"
    interval="5000"
    hide-delimiters
    show-arrows-on-hover
    :show-arrows="false"
  >
    <v-carousel-item v-for="(slide, i) in slides" :key="i">
      <v-simple-table light>
        <template v-slot:default>
          <thead>
            <tr id="title">
              <th class="text-center black--text font-weight-black">CÓDIGO</th>
              <th class="text-center black--text font-weight-black">DESCRIÇÃO</th>
              <th class="text-center black--text font-weight-black">PREÇO</th>
              <th class="text-center">
                <!--v-avatar size="100" tile>
                    <v-img
                      alt="Clube Paraná"
                      class="justify-center"
                      contain
                      :src="require('../assets/clubepsmitem.svg')"
                      transition="scale-transition"
                    />
                </v-avatar-->
              </th>
            </tr>
          </thead>
          <tbody class="text-md-subtitle-2 text-center black--text font-weight-regular">
            <tr v-for="item in data" :key="item.name">
              <td>{{ item.code }}</td>
              <td>{{ item.description }}</td>
              <td>{{ item.price }}</td>
              <td class="primary--text">{{ item.club }}</td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
    </v-carousel-item>
  </v-carousel>
</template>

<script>
export default {
  name: "CarouselTablePrice",

  data() {
    return {
      items_per_table: 10,
      slides: ["First", "Second"],
      data: [
        {
          code: 100015,
          description: "PIMENTA CALABREZA MINEIRINHA 30g",
          price: "R$12,25",
          club: "R$10,90"
        },
        {
          code: 105415,
          description: "AZEITE MENININHA (30% AZEITE)",
          price: "R$52,25",
          club: ""
        },
        {
          code: 100015,
          description: "MANTEIGUINHA AZEDA 1kg",
          price: "R$12,25",
          club: ""
        },
        {
          code: 100015,
          description: "PIMENTA CALABREZA MINEIRINHA 30g",
          price: "R$12,25",
          club: "R$10,90"
        },
        {
          code: 105415,
          description: "AZEITE MENININHA (30% AZEITE)",
          price: "R$52,25",
          club: "R$49,90"
        },
        {
          code: 100015,
          description: "MANTEIGUINHA AZEDA 1kg",
          price: "R$12,25",
          club: ""
        }
      ]
    };
  }
};
</script>

<style scoped>
#title {
  background-color: rgb(255, 0, 0, 0.5);
}

tr:nth-child(even) {
  background-color: rgb(255, 0, 0, 0.2);
}
</style>
