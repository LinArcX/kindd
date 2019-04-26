function getClearContext(canvas) {
    var context = canvas.getContext("2d")
    context.clearRect(0, 0, canvas.width, canvas.height)
    return context
}

// Lines
function drawLine(context, canvas) {
    context.beginPath()
    context.moveTo(0, 0)
    context.lineTo(canvas.width / 2, canvas.height / 3)
    context.stroke()
    context.closePath()
    return context
}

// Text
function drawText(context, canvas, fontColor, fontStyle, text, width, height) {
    context.fillStyle = fontColor
    context.font = fontStyle
    context.fillText(text, width, height)
    return context
}

// Triangles
function drawTriangle(context, x, y, width, height, fillColor, lineColor, lineWidth) {
    context.beginPath()
    context.moveTo(x, y)
    context.lineTo(x + width / 2, y + height)
    context.lineTo(x - width / 2, y + height)
    context.closePath()

    context.lineJoin = "round"
    context.strokeStyle = lineColor
    context.fillStyle = fillColor
    context.lineWidth = lineWidth

    context.fill()
    context.stroke()

    var obj = {
        context: context,
        x: x,
        y: y,
        width: width,
        height: height
    }
    return obj
}

// Circles
function drawRawCircle(context) {
    context.beginPath()
    context.fillStyle = "#4CAF50"
    context.arc(80, 80, 70, 0, 2 * Math.PI)
    context.fill()
}

function drawCircle(context, xPos, yPos, radius, startAngle, endAngle, anticlockwise, lineColor, fillColor, lineWidth) {
    startAngle = startAngle * (Math.PI / 180)
    endAngle = endAngle * (Math.PI / 180)

    context.strokeStyle = lineColor
    context.fillStyle = fillColor
    context.lineWidth = lineWidth

    context.beginPath()
    context.arc(xPos, yPos, radius, startAngle, endAngle, anticlockwise)
    context.fill()
    context.stroke()

    var obj = {
        context: context,
        width: xPos + 3 * radius,
        height: yPos + 2 * radius
    }
    return obj
}

// Rectangle
function drawRectangle(context, xPos, yPos, width, height, lineColor, fillColor, lineWidth) {
    context.strokeStyle = lineColor
    context.fillStyle = fillColor
    context.lineWidth = lineWidth

    context.beginPath()
    context.rect(xPos, yPos, width, height)
    context.fill()
    context.stroke()
    var obj = {
        context: context,
        width: xPos + 4 * width,
        height: yPos + 4 * height
    }
    return obj
}

// Global
function addTextToShape(context, text, textColor) {
    var mWidth = context.width
    var mHeight = context.height
    var mX = context.x
    var mY = context.y

    context.context.textAlign = "center"
    context.context.textBaseline = "middle"
    context.context.fillStyle = "black"
    context.context.font = "bold 15px 'Times New Roman', Times, serif"
    context.context.fillText("Low", mX / 2 + mWidth / 2 + mX / 6,
                             mY + mHeight / 2 + mY / 6)

    return context
}

function addOutlineStroke(context, lineWidth) {
    context.lineWidth = lineWidth
    context.lineJoin = "round"
    context.strokeStyle = "#333"
    context.stroke()
    return context
}

function getLineGradient(context, padding, height) {
    // Add a horizon reflection with a gradient to transparent
    var gradient = context.createLinearGradient(0, padding, 0, padding + height)
    gradient.addColorStop(0.5, "transparent")
    gradient.addColorStop(0.5, "#dcaa09")
    gradient.addColorStop(1, "#faf100")
    return gradient
}

function addOutLineStrokeGradient(context, padding, height, lineWidth) {
    var gradient = getLineGradient(context, padding, height)
    context.lineWidth = lineWidth
    context.lineJoin = "round"
    context.strokeStyle = gradient
    context.stroke()
    return context
}

// Garbage
function _drawTriangle(context, width, height, padding, text, textColor, textWidth, textHeight) {
    var trWidth = width
    var trHeight = height
    var trPadding = padding
    var trColor = "#ffc821"
    var strokeWidth = 5
    var txtLow = text
    var colorLow = textColor

    var triangle = createTriangle(context, trWidth, trHeight,
                                  trPadding, trColor)
    var triangleStroked = addOutlineStroke(triangle, strokeWidth)
    addTextToContext(triangle, trWidth, trHeight, txtLow, colorLow, textWidth,
                     textHeight)
}

function _sdrawTriangle(context, width, height, padding, lineColor, fillColor, lineWidth) {
    context.beginPath()
    context.moveTo(padding + width / 2, padding) // Top Corner
    context.lineTo(padding + width, height + padding) // Bottom Right
    context.lineTo(padding, height + padding) // Bottom Left
    context.closePath()

    context.lineJoin = "round"
    context.strokeStyle = lineColor
    context.fillStyle = fillColor
    context.lineWidth = lineWidth

    context.fill()
    context.stroke()

    var obj = {
        context: context,
        width: width,
        height: height
    }
    return obj
}


