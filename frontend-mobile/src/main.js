import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'
import 'vant/lib/index.css'
import { Button, Tabbar, TabbarItem, NavBar, Swipe, SwipeItem, Grid, GridItem, Card, Tag, SubmitBar, Step, Steps, Image as VanImage, Cell, CellGroup, Stepper, Empty, Form, Field, ActionBar, ActionBarIcon, ActionBarButton, Popup, Icon } from 'vant'

const app = createApp(App)

app.use(createPinia())
app.use(router)

// Register Vant components
app.use(Button).use(Tabbar).use(TabbarItem).use(NavBar)
   .use(Swipe).use(SwipeItem).use(Grid).use(GridItem)
   .use(Card).use(Tag).use(SubmitBar).use(Step).use(Steps)
   .use(VanImage).use(Cell).use(CellGroup).use(Stepper).use(Empty)
   .use(Form).use(Field).use(ActionBar).use(ActionBarIcon).use(ActionBarButton)
   .use(Popup).use(Icon)

app.mount('#app')
