#include <stdio.h>
#include <string.h>


#define MAX_SIZE 15


char tree[MAX_SIZE];
int idx=0;
int node=0;


void insert(char data) {
    if (idx >= MAX_SIZE) {
        printf("FULL\n");
        return;
    }

    if (tree[idx] == '\0') {
        tree[idx] = data;
        idx++;
        node++;
    }
    return;
}


void deleteNode(char data, int index,int * find) {
    if (index >= MAX_SIZE) {
        return;
    }
    if (tree[index] == data) {
        *find=1;
        node--;
        tree[index] = '\0';
        deleteNode(data, 2 * index + 1,find);
        deleteNode(data, 2 * index + 2,find);
    } else {
        deleteNode(data, 2 * index + 1,find);
        deleteNode(data, 2 * index + 2,find);
    }
    return;
}
void postorder(int index) {
    if (index >= MAX_SIZE || tree[index] == '\0') {
        return;
    }

    postorder(2 * index + 1);
    postorder(2 * index + 2);
    if (tree[index] != '\0') {
        printf("%c\n", tree[index]);
    }
    return;
}


void inorder(char data, int index, int* count) {
    if (index >= MAX_SIZE || tree[index] == '\0') {
        return;
    }

    inorder(data, 2 * index + 1, count);

    if (tree[index] != '\0') {
            (*count)++;
            printf("%c\n", tree[index]);
            if(tree[index]==data){
                    return;
            }
    }

    inorder(data, 2 * index + 2, count);
    return;
}
int main() {



    for (int i = 0; i < MAX_SIZE; i++) {
        tree[i] = '\0';
    }

    while (1) {
        char command[20];
        char data;
        scanf(" %s",command);
        if (strncmp(command, "INPUT", 5) == 0) {
            scanf(" %c", &data);
            insert(data);
        } else if (strncmp(command, "DELETE", 6) == 0) {
            int find=0;
            scanf(" %c", &data);
            deleteNode(data, 0,&find);
            if(find==0){
              printf("NONE\n");
            }
        } else if (strncmp(command, "LIST", 4) == 0) {
            postorder(0);
        } else if (strncmp(command, "FIND", 4) == 0) {
            scanf(" %c", &data);
            int count = 0;
            inorder(data, 0, &count);
            if (count == node) {
            printf("NONE\n");
            } else {
            printf("%d\n",count);
            }
        }
    }
return 0;
}


