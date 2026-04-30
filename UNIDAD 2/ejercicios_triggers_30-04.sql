

delimiter //

create trigger insertAAudit after insert on customers
for each row
begin
	insert into customers_audit values("insert",new.customerNumber,current_date(),new.customerName,new.phone,new.addressLine1,new.city,new.country);
end//

create trigger antesDeModifcar after update on customers
for each row
begin
	insert into customers_audit values("update",old.customerNumber,current_date(),old.customerName,old.phone,old.addressLine1,old.city,old.country);
end//

create trigger antesDeFunarlo after delete on customers
for each row
begin
	insert into customers_audit values("delete",old.customerNumber,current_date(),old.customerName,old.phone,old.addressLine1,old.city,old.country);
end//

delimiter ;

