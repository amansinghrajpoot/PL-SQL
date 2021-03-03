create or replace type second_max
as object (
          maximum number,
          second_maximum number,

          static function ODCIAggregateInitialize(sm_obj in out second_max) return number,
          member function ODCIAggregateIterate(self in out second_max, col_val in number) return number,
          member function ODCIAggregateTerminate(self in out second_max, re_val out number, flags in number) return number,
          member function ODCIAggregateMerge(self in out second_max, sm_obj2 in second_max) return number
 );

/
create or replace type body second_max as
    static function ODCIAggregateInitialize(sm_obj in out second_max) return number as
        begin
            sm_obj := second_max(0, 0);
            return ODCICONST.Success;
    end;
    
    member function odciaggregateIterate(self in out second_max, col_val in number) return  number as
        begin
            if col_val >= self.maximum then
                self.maximum := col_val;
            elsif col_val > self.second_maximum then
                self.second_maximum := col_val;
            end if;
              RETURN ODCIConst.Success;
        end;
        
    member function ODCIAggregateTerminate(self in out second_max, re_val out number, flags in number) return number as
        begin
            re_val := self.second_maximum;
            return ODCICONST.Success;
        end;
     member function ODCIAggregateMerge(self in out second_max, sm_obj2 in second_max) return number as
      begin
            IF sm_obj2.maximum > self.maximum THEN
                         IF sm_obj2.second_maximum > self.second_maximum THEN
                                     self.second_maximum := sm_obj2.second_maximum;
                         ELSE
                                     self.second_maximum := self.maximum;
                        END IF;
                        self.maximum := sm_obj2.maximum;
            ELSIF
                        sm_obj2.maximum > self.second_maximum THEN
                         self.second_maximum := sm_obj2.maximum;
            END IF;
            return ODCICONST.Success;
      end;
end;
    /
create or replace function  second_maximum(input number) return number aggregate using second_max;
/
select second_maximum(SALARY) from EMPLOYEES;

