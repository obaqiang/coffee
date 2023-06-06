<template>
  <div>
    <el-form label-width="80px" :model="form">
      <el-row>
        <el-col :span="12">
          <el-form-item label="变量">
            <draggable
              v-model="varArr"
              :group="group1"
              :sort="false"
              animation="300"
              dragClass="dragClass"
              ghostClass="ghostClass"
              chosenClass="chosenClass"
              @start="onStart"
              @end="onEndVar"
            >
              <transition-group>
                <div class="item" v-for="(item, index) in varArr" :key="index">
                  <el-tag>
                    {{ item.name }}
                  </el-tag>
                </div>
              </transition-group>
            </draggable>
          </el-form-item>
          <el-form-item label="常量">
            <draggable
              v-model="constArr"
              :group="group1"
              :sort="false"
              animation="300"
              dragClass="dragClass"
              ghostClass="ghostClass"
              chosenClass="chosenClass"
              @start="onStart"
              @end="onEndVar"
            >
              <transition-group>
                <div
                  class="item"
                  v-for="(item, index) in constArr"
                  :key="index"
                >
                  <el-tag>
                    {{ item.name }}
                  </el-tag>
                </div>
              </transition-group>
            </draggable>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="公式">
            <draggable
              v-model="fnArr"
              :sort="false"
              :group="group2"
              animation="300"
              dragClass="dragClass"
              ghostClass="ghostClass"
              chosenClass="chosenClass"
              @start="onStart"
              @end="onEndFn"
            >
              <transition-group>
                <div class="item" v-for="(item, index) in fnArr" :key="index">
                  <el-tag>{{ item.name }}</el-tag>
                </div>
              </transition-group>
            </draggable>
          </el-form-item>
          <el-form-item label="操作符">
            <draggable
              v-model="operateArr"
              :sort="false"
              :group="group2"
              animation="300"
              dragClass="dragClass"
              ghostClass="ghostClass"
              chosenClass="chosenClass"
              @start="onStart"
              @end="onEnd"
            >
              <transition-group>
                <div
                  class="item"
                  v-for="(item, index) in operateArr"
                  :key="index"
                >
                  <el-tag>{{ item.name }}</el-tag>
                </div>
              </transition-group>
            </draggable>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="操作区">
        <div style="width: 100%">
          <draggable
            v-model="expArr"
            :group="group3"
            animation="300"
            dragClass="dragClass"
            ghostClass="ghostClass"
            chosenClass="chosenClass"
            class="drag-area"
            @start="onStart"
            @end="onEnd"
          >
            <transition-group>
              <div
                class="item"
                v-for="(item, index) in expArr"
                :key="Math.random()"
              >
                <!-- @contextmenu.prevent.stop="showDeleteTag(index, item.id)" -->
                <el-tag>
                  {{ item.name }}
                </el-tag>
                <div
                  :key="index"
                  class="self-delete"
                  v-show="item.showDelete"
                  @click="handleDeleteTag(index)"
                >
                  删除
                </div>
              </div>
            </transition-group>
          </draggable>
        </div>
      </el-form-item>

      <el-form-item>
        <div class="remove-area">
          <el-button type="warning" @click="handleResetExp">重置</el-button>
          <div class="remove-right">
            <p class="garbage-text">拖入右侧回收区删除</p>
            <el-icon class="garbage-icon" color="#909399"><Delete /></el-icon>
            <draggable
              :group="group3"
              animation="300"
              dragClass="dragClass"
              ghostClass="ghostClass"
              chosenClass="chosenClass"
              class="garbage-area"
              @start="onStart"
              @end="onEndGarbage"
            >
              <transition-group> </transition-group>
            </draggable>
          </div>
        </div>
      </el-form-item>
      <el-form-item label="表达式">
        <!-- <el-input readonly v-model="form.exp"></el-input> -->
        <div class="show-area">
          {{ form.exp }}
        </div>
      </el-form-item>
      <el-form-item>
        <!-- <el-button @click="handleReset">重置</el-button> -->
        <el-button @click="handlerConfirm" type="primary">确定</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { ElMessage } from "element-plus";
import { toRaw } from "vue";
import { VueDraggableNext } from "vue-draggable-next";
import { Delete, Edit, Search, Share, Upload } from "@element-plus/icons-vue";
export default {
  components: {
    draggable: VueDraggableNext,
    Delete
  },

  data() {
    return {
      dialogKey: "dialogKey",
      form: {
        exp: "",
      },
      varArr: [
        { id: 1, type: "var", name: "SINGLE_VOLT" },
        { id: 2, type: "var", name: "SINGLE_TEMP" },
      ],

      fnArr: ["MAX", "MIN", "AVG"].map((item, index) => {
        return {
          id: index + 1,
          type: "fn",
          name: item,
          showDelete: false,
        };
      }),
      constArr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "."].map((item, index) => {
        return {
          id: index + 1,
          type: "constant",
          name: item,
          showDelete: false,
        };
      }),
      operateArr: [
        "+",
        "-",
        "*",
        "/",
        ">",
        "≥",
        "<",
        "≤",
        "=",
        "and",
        "or",
        "(",
        ")",
      ].map((item, index) => {
        return {
          id: index + 1,
          type: "operate",
          name: item,
          showDelete: false,
        };
      }),
      expArr: [],

      drag: false,
      group1: {
        name: "site",
        pull: "clone",
        put: false,
      },
      group2: {
        name: "site",
        pull: "clone",
        put: false,
      },
      group3: {
        name: "site",
        pull: true,
        put: true,
      },
      verifyMes: "",
      nodeModel: null,
      properties: [],
    };
  },
  watch: {
    expArr: {
      handler(newVal) {
        if (newVal) {
          this.verifyMes = "";
          this.form.exp = newVal.reduce((a, b, i) => {
            if (b.type == "operate") {
              if (!newVal[i - 1]) {
                this.verifyMes = "操作符不能作为表达式首位";
              }
              if (newVal[i - 1]) {
                if (newVal[i - 1].type == "fn") {
                  this.verifyMes = "操作符不能作为函数后第一个参数";
                }

                if (newVal[i - 1].type == "operate") {
                  this.verifyMes = "不能出现连续的操作符";
                }
              }
              if (newVal[i + 1]) {
                if (newVal[i + 1].type == "help") {
                  this.verifyMes = "操作符后不能直接放置括号作为参数";
                }
              }
            }
            if (b.type == "constant") {
              if (b.name == ".") {
                if (newVal[i - 1]) {
                  if (newVal[i - 1].type != "constant") {
                    this.verifyMes = "小数点两端必须为常量数字";
                  }
                }
                if (newVal[i + 1]) {
                  if (newVal[i + 1].type != "constant") {
                    this.verifyMes = "小数点两端必须为常量数字";
                  }
                }
              }
              if (newVal[i - 1]) {
                if (newVal[i - 1].type == "var") {
                  this.verifyMes = "常量和变量之间需要存在操作符";
                }
              }
              if (newVal[i + 1]) {
                if (newVal[i + 1].type == "var") {
                  this.verifyMes = "常量和变量之间需要存在操作符";
                }
              }
            }
            if (b.type == "var" || b.type == "fn") {
              if (newVal[i - 1]) {
                if (
                  newVal[i - 1].type == "var" ||
                  newVal[i - 1].type == "help"
                ) {
                  a += " " + ",";
                }
              }
            }
            if (b.type == "constant") {
              if (newVal[i - 1] && newVal[i - 1].type == "constant") {
                a += b.name;
              } else {
                a += " " + b.name;
              }
            } else {
              if (b.name == "≤") {
                a += " " + "<=";
              } else if (b.name == "≥") {
                a += " " + ">=";
              } else {
                a += " " + b.name;
              }
            }
            return a;
          }, "");
        }
      },
      immediate: true,
      deep: true,
    },
  },
  mounted() {},
  methods: {

    onEndGarbage() {},

    showDeleteTag(itemIndex, itemId) {
      if (this.expArr[itemIndex].id == itemId) {
        console.log(this.expArr[itemIndex]);
        this.expArr[itemIndex].showDelete = !this.expArr[itemIndex].showDelete;
      }
    },
    handleDeleteTag(itemIndex) {
      this.expArr.splice(itemIndex, 1);
    },

    handlerConfirm() {
      this.dialogKey = Math.random();

      if (this.verifyMes) {
        ElMessage.error(this.verifyMes);
      } else {
        ElMessage.success('函数构建成功');
      }
    },
    handleResetExp() {
      this.expArr = [];
      // console.log(this.expArr);
    },
    onStart() {},
    onEnd(e) {},
    onEndVar(e) {},
    onEndFn(e) {
      const { oldIndex, newIndex } = e;
      const newFn = {
        id: Math.random(),
        type: "fn",
        name: `${this.fnArr[oldIndex].name}(`,
      };
      const helpPart = {
        id: Math.random(),
        name: `)`,
        type: "help",
        showDelete: false,
      };

      const newExpArrHead = this.expArr
        .slice(0, newIndex)
        .map((obj) => toRaw(obj));

      const newExpArrBody = this.expArr
        .slice(newIndex + 1)
        .map((obj) => toRaw(obj));

      const newExpArr = [...newExpArrHead, newFn, ...newExpArrBody, helpPart];

      this.expArr = [];
      this.expArr = newExpArr;
    },
  },
};
</script>

<style scoped>
.exp-area {
  background-color: red;
  min-height: 100px;
  width: 500px;
}
.ghostClass {
  /* background-color: blue !important; */
}

.chosenClass {
  /* background-color: red !important; */
  opacity: 1 !important;
}

.dragClass {
  /* background-color: blueviolet !important; */
  opacity: 1 !important;
  box-shadow: none !important;
  outline: none !important;
  background-image: none !important;
}

.itxst {
  margin: 10px;
}

.title {
  padding: 6px 12px;
}

.col {
  width: 40%;
  flex: 1;
  padding: 10px;
  border: solid 1px #eee;
  border-radius: 5px;
  float: left;
}

.col + .col {
  margin-left: 10px;
}
.item {
  /* padding: 6px 12px; */
  /* margin: 0px 10px 0px 10px; */
  margin: 5px;
  border: solid 1px #eee;
  background-color: #f1f1f1;
  display: inline-block;
  position: relative;
}

.item:hover {
  background-color: #fdfdfd;
  cursor: move;
}

.item + .item {
  border-top: none;
  margin-top: 6px;
}
.self-delete {
  position: absolute;
  width: 30px;
  /* height: 30px; */
  background-color: #ffffff;
  /* right: 0; */
  /* text-align: center; */
  /* display: flex;
    justify-content: center;
    align-items: center; */
  font-size: 12px;
  line-height: 18px;
  border: 1px solid #efefee;
  text-align: center;
  cursor: pointer;
}
.drag-area {
  background-color: #ffffff;
  border: 1px solid #409eff;
  min-width: 100%;
  border-radius: 5px;
  min-height: 45px;
}
.show-area {
  border: 1px solid #67c23a;
  border-radius: 5px;
  padding: 10px;
  min-width: 100%;
  min-height: 45px;
  box-sizing: border-box;
}
.garbage-area {
  display: inline-block;
  border: 1px solid #dddddd;
  border-radius: 5px;

  width: 150px;
  height: 35px;
  box-sizing: border-box;
  /* margin: 10px; */

  /* background-color: rgb(241, 241, 241); */
  background-image: linear-gradient(to right, #dddddd 1px, transparent 1px),
    linear-gradient(to bottom, #dddddd 1px, transparent 1px);
  background-size: 5px 5px;
}
.garbage-text {
  margin: 10px;
  color: #909399;
}
.remove-area {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.garbage-icon {
  position: absolute;
  right: 10px;
  background-color: #ffffff;
}
.remove-right {
  display: flex;
  align-items: center;
}
</style>
