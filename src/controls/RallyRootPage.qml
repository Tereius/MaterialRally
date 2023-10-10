import QtQuick
import QtQuick.Controls
import MaterialRally 1.0 as Controls

// Use this Item as the entrypoint if you use QQuickView::setSource
Page {

    id: root

    Controls.RootItem.contentItem: root.contentItem
    Controls.RootItem.header: root.header
    Controls.RootItem.footer: root.footer

    Window.onWindowChanged: {

        Window.window.color = Material.backgroundColor
    }
}
