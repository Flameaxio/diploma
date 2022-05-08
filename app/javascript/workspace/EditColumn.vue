<template>
	<div class="text-center">
		<v-dialog v-model="dialog" class="dialog">
			<template v-slot:activator="{ on, attrs }">
				<div class="openButton" v-bind="attrs" v-on="on"><v-icon> mdi-cog </v-icon></div>
			</template>

			<v-card>
				<v-card-title class="text-h5 grey lighten-2"> Edit webhook </v-card-title>

				<v-card-text style="overflow-y: scroll">
					<div class="input"><v-text-field label="Name" v-model="name" /></div>
					<div class="input">
						<v-switch label="Enable webhook" v-model="enabled" />
					</div>
					<div style="height: 800px; position: relative">
						<div :class="!enabled ? 'disabled-wrapper' : ''" />
						<div class="url-wrapper">
							<v-text-field label="URL" v-model="url" :disabled="!enabled" />
							<v-tooltip bottom>
								<template v-slot:activator="{ on, attrs }">
									<v-btn icon color="primary" dark v-bind="attrs" v-on="on">
										<v-icon> mdi-help </v-icon>
									</v-btn>
								</template>
								<span v-pre
									>JSON body supports string interpolation for variables in {{}}.</span
								>
								<span v-pre>The following variables are available: </span>
								<ul>
									<li>assignee - returns assignees full name</li>
									<li>assignee_email - returns assignees email</li>
									<li>ticket_number - returns ticket number</li>
									<li>ticket_title - returns ticket title</li>
									<li>column_name - returns column name</li>
								</ul>
							</v-tooltip>
						</div>
						<JSONEditor
							:class="!enabled ? 'disabled-editor' : ''"
							style="min-height: 800px"
							:onChange="onChange"
							:json="body"
						/>
					</div>
				</v-card-text>

				<v-divider></v-divider>

				<v-card-actions>
					<v-spacer></v-spacer>
					<v-btn color="primary" text @click="closeAndSave"> Save </v-btn>
				</v-card-actions>
			</v-card>
		</v-dialog>
	</div>
</template>

<script>
import JSONEditor from 'vue2-jsoneditor'
import { mapActions } from 'vuex'

export default {
	components: { JSONEditor },
	props: { column: { type: Object, required: true } },
	data() {
		return {
			dialog: false,
			enabled: !!(this.column.webhook?.url && this.column.webhook?.body),
			name: this.column.name,
			url: this.column.webhook?.url,
			body: JSON.parse(this.column.webhook?.body || '{}'),
			newBody: {}
		}
	},
	methods: {
		...mapActions(['updateColumn']),
		close() {
			this.dialog = false
		},
		onChange(newJson) {
			this.newBody = newJson
		},
		async closeAndSave() {
			const params = {
				id: this.column.id,
				name: this.name
			}
			if (this.enabled) {
				params.url = this.url
				params.body = JSON.stringify(this.newBody)
			}
			await this.updateColumn(params)
			this.close()
		}
	}
}
</script>

<style lang="scss">
.jsoneditor {
	height: 800px !important;
}
</style>

<style scoped lang="scss">
.openButton {
	cursor: pointer;
}

.backdrop {
	position: absolute;
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background: #666666;
	cursor: pointer;
}

.dialog {
	width: 60vw;
	min-height: 800px;
	background-color: white;
	position: absolute;
	top: 10vh;
	left: 20vw;
	z-index: 999999;
}

.top {
	width: 100%;
	height: 32px;
	display: flex;
	flex-direction: row-reverse;
	border-bottom: 1px solid #333333;
	.icon {
		height: 32px;
		width: 32px;
		font-size: 20px;
		display: flex;
		justify-content: center;
		align-items: center;
		background: transparent;
		border: none;
		cursor: pointer;
	}
}

.dialog-content {
	box-sizing: border-box;
	padding: 20px;
	min-height: 800px;
}

.input {
	display: flex;
	flex-direction: row;
	width: 30%;
	justify-content: space-between;
	padding-bottom: 20px;
}

.disabled-wrapper {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	cursor: not-allowed;

	z-index: 9999;
}

.disabled-editor {
	filter: grayscale(100%);
}

.url-wrapper {
	display: flex;
	flex-direction: row;
	align-items: center;
}
</style>
