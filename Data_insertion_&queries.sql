-- Usar a tabela e-commerce
use ecommerce;
 
show tables;
-- Inserção de dados e queries

-- idClient, Fname, Minit, Lname, CPF, Address
insert into clients(Fname, Minit, Lname, CPF, Address)
	 values('Maria', 'M', 'Silva', 12346789, 'rua silva de prata 29'),
		   ('Matheus', 'O', 'Plantel', 987654321, 'rua almeda 289'),
           ('Ricardo', 'F', 'silva', 4567891, 'avenida almeda vinho 1809'),
           ('Julia', 'S', 'França', 789123456, 'rua lareijnas 861'),
           ('Roberta', 'G', 'Assis', 98746631, 'avenidade koller 19'),
           ('Isabela', 'G', 'Assis', 98745631, 'rua almeda das flores 28');

-- idproduct, Pname, classification_kids, category, Prating, size
insert into products(idProduct, Pname, classification_kids, category, Prating, size)
	 values(1,'FoneOuvido', false, 'Electronics', '4', null),
           (2,'Barbie', true, 'Toys', '3', null),
           (3,'Babycare', true, 'Clothing', '5', null),
           (5,'Microfone', false, 'Electronics', '4', null),
           (6,'Sofa', false, 'Furnitures', '3', '3x57x80'),
           (7,'farinha', false, 'Food&beverages', '2', null),
           (8,'FireStick', false, 'Electronics', '3', null);
           
-- idOrder, idOrderClient, orderstatus, orderDescription, Freight, paymentCash
insert into orders(idOrderClient, orderstatus, orderDescription, Freight, paymentCash)
     values(1, default, 'compra via aplicativo', 40, 1),
           (2, default, 'compra via aplicativo', 50, 0),
           (3, 'Confirmado', 'compra via aplicativo',35, 1),
           (4, 'Confirmado', 'compra vai site', 45, 1),
           (5, default, 'compra via site', 150, 0),
           (6, default, 'compra via site', 120,1);
           
-- idProdorder, idPoproduct, POquantity, prodStatus
insert into prodOders(idProdorder, idPoproduct, POquantity, prodStatus)
     values(1,5,1,default),  
		   (2,5,1,default),
           (3,6,1,default),
           (4,7,2,default),
           (5,3,2,default),
           (6,2,1,default);
           

-- storagelocation, Squantity
insert into prodstorage(storagelocation, Squantity)
     values('Rio de janeiro', 1000),
           ('Rio de janeiro', 500),
           ('São paulo',10),
           ('São paulo', 100),
           ('São paulo',10),
           ('Brasilia',60);

-- idSupplier, socialName, CNPJ, contact
insert into suppliers(socialName, CNPJ, contact)
     values('Almeda e filhos', 123450089123456, '21985474'),
           ('Eletronicos Silva', 833319649143452, '21985484'),
           ('Eletronicos valna', 934562293934695, '21975474');
           
-- idLproduct, idLstorage, location
insert into productlocation(idLproduct, idLstorage, location)
     values(1,2,'RJ'),
           (2,6,'BR'),
           (3,3,'SP');
           
           
-- idPsSupplier, idPsproduct, quantity
insert into prodsupplier(idPsSupplier, idPsproduct, quantity)
     values(1,1,500),
		   (2,2,400),
           (3,3,633);
           
           
-- socialName, CNPJ, CPF, contact, location
insert into sellers(socialName, CNPJ, CPF, contact, location)
     values('Tech eletronics', 155987654234987, 989698766, 219946287, 'RJ'),
           ('Boutique Durgas', 984663264387646, 778721234, 219567895,'RJ'),
           ('Kids World', 239878838747389, 111398476, 1198657484, 'SP');

-- idProdseller, idProduct, Pquantity
insert into prodseller(idProdseller, idPproduct, Pquantity)
     values(1,2,80),
           (2,1,10),
           (3,3,40);
           
-- queries
select * from prodseller;
select count(*) from clients;

select * from clients c, orders o where o.idOrderClient = c.idClient;

select Lname, Fname, idOrder, orderstatus from clients c, orders o where o.idOrderClient = c.idClient;

select concat(Fname, ' ', Lname) clients, idOrder, orderstatus from clients c, orders o where o.idOrderClient = c.idClient;

select * from clients left join orders on idOrderClient = idClient;

select * from clients c inner join orders o on o.idOrderClient = c.idClient
                   inner join prododers p on p.idProdorder = o.idOrder;
                   
select * from products;
select * from clients;

-- recuperação do pedido com idProduto, Categoria, nome do produto associado   

select Pname, Fname, Lname, classification_kids, category from products, clients where classification_kids = 1;  

select * from clients c, products pr
                 right join prododers p on p.idPoproduct = pr.idProduct;
                 
select * from clients c, products pr
                 right join prodsupplier ps on ps.idPsproduct = pr.idProduct;
                 
             
select * from clients c
                 inner join orders o on o.idOrderClient = c.idClient
                 inner join prododers p where p.idPoproduct = o.idOrder;
                 
                 
-- quantos pedidos foram realizados pelos clientes                   
select c.idClient, Fname, count(*) as Num_of_orders from clients c
                 inner join orders o on o.idOrderClient = c.idClient
                 group by idClient;