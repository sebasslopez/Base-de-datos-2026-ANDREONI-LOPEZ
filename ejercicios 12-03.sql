/*#6
create view clientesnopago as select p.* from payments p 
left join customers c on c.customerNumber = p.customerNumber
where c.customerNumber is null;

#10
create view clientessipago as select c.customerName,c.phone,c.addressLine1 from payments p 
join customers c on c.customerNumber = p.customerNumber
where p.paymentDate < 2024 and p.amount > 30000;

#11
create view llegoono as select * from orders
where status = 'cancel' or status = 'resolved';
*/

#13
create view orden as select customerNumber from orders
group by customerNumber
order by count(customerNumber) desc limit 1;