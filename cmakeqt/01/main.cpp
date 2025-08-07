#include <QDebug>
#include <QStack>
int main(int argc, char **argv)
{
    QStack<int> stack;
    stack.push(1);
    stack.push(2);
    stack.push(3);
    while (!stack.isEmpty())
    {
        qDebug() << stack.pop();
    }
    return 0;
}
