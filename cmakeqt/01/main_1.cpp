#include <QApplication>
#include <QCheckBox>
#include <QDebug>
#include <QMainWindow>
#include <QObject>
#include <QPushButton>
int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    QObject *btn = new QPushButton();
    const QMetaObject *metaObj = btn->metaObject();
    qDebug() << "metaObj: " << metaObj->className();

    QPushButton *btnPush = qobject_cast<QPushButton *>(btn);

    const QMetaObject *metaObj2 = btn->metaObject();

    qDebug() << metaObj2->className();

    QCheckBox *checkbox = qobject_cast<QCheckBox *>(btn);
    qDebug() << checkbox;



	QMetaObject::Connection QObject::connect(const QObject *sender, const char *signal, const QObject *receiver, const char *member);
    return app.exec();
}
