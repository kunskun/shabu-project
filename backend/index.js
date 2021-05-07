const express = require("express")
var cors = require('cors')
const path = require("path")

const app = express();
const { logger } = require('./middlewares')
app.use(logger)

app.use(cors())
// Statics
app.use(express.static('static'))

app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

// routers
const indexRouter = require('./routes/index')
// const managerRouter = require('./routes/manager')
const commentRouter = require('./routes/comment')
const posRouter = require('./routes/pos')
const userRouter = require('./routes/user')
const orderRouter = require('./routes/ordermenu')
// manager
const saleRouter = require('./routes/manager/sale')
const orderManageRouter = require('./routes/manager/order')
const matRouter = require('./routes/manager/materials')
const customerRouter = require('./routes/manager/customer')
const dayRouter = require('./routes/manager/dayAccount')
const feedbackRouter = require('./routes/manager/feedback')
const employeeRouter = require('./routes/manager/employee')
const monthRouter = require('./routes/manager/monthAccount')
const menuRouter = require('./routes/manager/menu')

app.use(indexRouter.router)
// app.use(managerRouter.router)  
app.use(commentRouter.router)
app.use(posRouter.router)
app.use(orderRouter.router)
app.use(userRouter.router)

// manager
app.use(saleRouter.router)
app.use(orderManageRouter.router)
app.use(matRouter.router)
app.use(customerRouter.router)
app.use(dayRouter.router)
app.use(feedbackRouter.router)
app.use(employeeRouter.router)
app.use(monthRouter.router)
app.use(menuRouter.router)

app.listen(3000, () => {
  console.log(`Example app listening at http://localhost:3000`)
})