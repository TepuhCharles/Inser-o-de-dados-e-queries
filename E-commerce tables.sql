-- Criação do banco de dados para o cenario E-commerce
create database ecommerce;
use ecommerce;
-- criar tabela Client
Create table clients(
     idClient int auto_increment primary key,
     Fname varchar(10),
     Minit char(3),
     Lname varchar(20),
     CPF char(11),
     Address varchar(30),
     constraint unique_cpf_client unique(CPF)
);
-- Criar tabela Product
create table Products(
      idProduct int primary key,
      Pname varchar(10) not null,
      classification_kids bool default false,
      category enum('Electronics','Toys','Clothing','Food&beverages','Furnitures') not null,
      Prating float default 0,
      size varchar(10)
);
-- Criar tabela Order
create table Orders(
     idOrder int auto_increment primary key,
     idOrderClient int not null,
     orderstatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
     orderDescription varchar(90) not null,
     Freight float default 10 not null,
     PaymentCash bool default false,
     constraint fk_orders_client foreign key(idOrderClient) references clients(idClient)
);
-- Criar tabela Estoque
create table prodStorage(
     idPstorage int auto_increment primary key,
     storagelocation varchar(95) not null,
     Squantity int default 0
);
-- Criar tabela fornecedor
create table supplier(
     idSupplier int auto_increment primary key,
     socialName varchar(90) not null,
     CNPJ char(15) not null,
     contact char(11) not null,
     constraint unique_supplier unique (CNPJ)
);
-- Criar tabela Vendedor terceiro
create table sellers(
      idSeller int auto_increment primary key,
      socialName varchar(90) not null,
      CNPJ char(15) not null,
      CPF char(9) not null,
      contact char(11),
      location varchar(20),
      constraint unique_seller_cnpj unique(CNPJ),
      constraint unique_seller_cpf unique(CPF)
);
-- Criar tabela vendedor produto (terceiro)
create table prodSeller(
     idProdseller int,
     idPproduct int,
     Pquantity int default 1,
     primary key(idProdseller, idPproduct), 
     constraint fk_prodseller foreign key(idProdseller) references sellers(idSeller),
     constraint fk_product foreign key(idPproduct) references Products(idProduct)
);
-- Criar tabela produtos por pedido
create table prodOders(
     idProdorder int,
     idPoproduct int,
     POquantity int default 1,
     prodStatus enum('Disponível', 'Sem estoque') default 'Disponível',
     primary key(idProdorder, idPoproduct),
     constraint fk_prodOrders foreign key(idProdorder) references Products(idProduct),
     constraint fk_prodOrders_product foreign key(idPoproduct) references Orders(idOrder)
);
-- Criar tabela produtos no estoque
create table productLocation(
      idLproduct int,
      idLstorage int,
      location varchar(90) not null,
      primary key( idLproduct, idLStorage),
      constraint fk_Lproduct foreign key(idLproduct) references Products(idProduct),
      constraint fk_Lstorage foreign key(idLstorage) references prodStorage(idPstorage)
);
-- Criar tabela produto fornecedor
create table prodSupplier(
      idPsSupplier int,
      idPsproduct int,
      quantity int not null,
      constraint fk_prodSupplier primary key(idPsSupplier, idPsproduct),
      constraint fk_PsSupplier foreign key(idPsSupplier) references products(idProduct),
      constraint fk_Psproduct foreign key(idPsproduct) references supplier(idSupplier)
);

use ecommerce;
use information_schema;
show tables;
desc table_constraints;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce' 