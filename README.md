# BinaryTree_SIC/XE
- Implementing Binary Tree Data structure with SIC/XE Instruction Set

## Goal
- Implementing commands `INPUT`, `LIST`, `DELETE`, `FIND` for Binary Tree with 15 nodes.
- Using proper `SIC directive` to implement the tree.
- Must use `Recursive Call` when you implement `LIST`, `DELETE`, `FIND`.

## Binary Tree specification
- In this project, you use array to make binary tree.
- ex)

 <img width="841" alt="image" src="https://github.com/JongHoB/BinaryTree_SIC-XE/assets/78012131/92abaac6-b80d-467a-ad7f-d655888d5722">

## `INPUT` command
- If you command `INPUT A`, you will insert alphabet `A` to the tree.
- You will only insert only 1 alphabet each time.
- IF the tree is full (15 nodes), you will print out "FULL".
- ex)

<img width="1081" alt="image" src="https://github.com/JongHoB/BinaryTree_SIC-XE/assets/78012131/6f7a8189-c594-437c-9254-759a7de755e5">


## `LIST` command
- command `LIST`
- Print all nodes' data using `POSTORDER` traversal.
- ex)

  <img width="1073" alt="image" src="https://github.com/JongHoB/BinaryTree_SIC-XE/assets/78012131/ba67ce6b-42b9-44e0-88a8-dd4860c1d6a2">


## `DELETE` command
- DELETE node's data with its all child nodes.
- If you command `DELETE D`, you delete alphabet `D` in the tree.(Convert the data to `NULL`. NULL in Hexadecimal is `0x00`)
- If there is no alphabet to delete, print out `NONE`.
- ex)

  <img width="1078" alt="image" src="https://github.com/JongHoB/BinaryTree_SIC-XE/assets/78012131/f12d438e-25a5-43fc-955e-ab53969ebb7f">


## `FIND` command
- FIND data using `INORDER` traversal.
- Print the data of all nodes of a binary tree using Inorder traversal and the times.
- If there is no alphabet, traverse all nodes and print out `NONE`.
- `NULL` node should not be printed out.
- ex)
<img width="587" alt="image" src="https://github.com/JongHoB/BinaryTree_SIC-XE/assets/78012131/a52b3345-e3f6-42df-901b-7f52fff5ecdc">
<img width="629" alt="image" src="https://github.com/JongHoB/BinaryTree_SIC-XE/assets/78012131/0945ad84-fbf1-449c-9ead-cd990be70805">


## Implementation
- `ref.c` is the reference code written in C(high-level language) before writing Assembly Code `binarytree.asm`.
- There could be an error.
