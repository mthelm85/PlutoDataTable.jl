module PlutoDataTable

using JSON2
using Random
using Tables

export data_table

"""
    data_table(table; items_per_page = 10)

Display `table` as an interactive data table. `table` is any tabular data structure supporting the Tables.jl interface. The
`items_per_page` keyword argument determines the number of rows to display at one time (default is 10).
"""

function data_table(table; items_per_page = 10)
	app_id = randstring('a':'z')
	d = Dict(
    "headers" => [Dict("text" => string(name), "value" => string(name)) for name in Tables.columnnames(table)],
    "data" => [Dict(string(name) => row[name] for name in Tables.columnnames(table)) for row in Tables.rows(table)]
)
	djson = JSON2.write(d)
	
	return HTML("""
		<link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
		<link href="https://cdn.jsdelivr.net/npm/vuetify@2.3.14/dist/vuetify.min.css" rel="stylesheet">

	  <div id="$app_id">
		<v-app>
		  <v-data-table
		  :headers="headers"
          :items="data"
          :items-per-page = $items_per_page
		></v-data-table>
		</v-app>
	  </div>

	  <script src="https://cdn.jsdelivr.net/npm/vue@2.6.12/dist/vue.js"></script>
	  <script src="https://cdn.jsdelivr.net/npm/vuetify@2.3.14/dist/vuetify.js"></script>
	
	<script>
		new Vue({
		  el: '#$app_id',
		  vuetify: new Vuetify(),
		  data () {
				return $djson
			}
		})
	</script>
	<style>
		.v-application--wrap {
			min-height: 10vh;
		}
		.v-data-footer__select {
			display: none;
		}
	</style>
	""")
end

end
