--Necromantic Spell Circle
function c77777754.initial_effect(c)
 --Activate
 local e1=Effect.CreateEffect(c)
 e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
 e1:SetDescription(aux.Stringid(77777754,0))
 e1:SetType(EFFECT_TYPE_ACTIVATE)
 e1:SetCode(EVENT_FREE_CHAIN)
-- e1:SetCountLimit(1,77777754)
-- e1:SetCondition(c77777754.condition)
 e1:SetTarget(c77777754.target)
 e1:SetOperation(c77777754.activate)
 c:RegisterEffect(e1)
end

function c77777754.filter(c,e,tp,m1)
 if not c:IsSetCard(0x1c8) or bit.band(c:GetType(),0x81)~=0x81
 or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
 local mg=m1:Filter(Card.IsCanBeRitualMaterial,c,c)
 if c:IsCode(21105106) then return c:ritual_custom_condition(mg) end
 if c.mat_filter then
 mg=mg:Filter(c.mat_filter,nil)
 end
 return mg:CheckWithSumGreater(Card.GetRitualLevel,c:GetLevel(),c)
end
function c77777754.mfilter(c)
 return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c77777754.filter2(c,e,tp,lv)
 if not c:IsSetCard(0x1c8) or bit.band(c:GetType(),0x81)~=0x81
 or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) or c:GetLevel()>lv then return false else
 return true end
end
function c77777754.filter3(c)
	return false
end
function c77777754.costfilter2(c,e,tp,lv)
return c:IsCode(77777748) and not c:IsDisabled() and c:GetCounter(0x666)>=lv
end
function c77777754.costfilter(c,e,tp)
 if not c:IsSetCard(0x1c8) or bit.band(c:GetType(),0x81)~=0x81
 or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) or not Duel.IsExistingMatchingCard(c77777754.costfilter2,tp,LOCATION_SZONE,0,1,nil,e,tp,c:GetLevel()) then return false else
 return true end
end
function c77777754.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg1=Duel.GetRitualMaterial(tp)
-- local mg2=Duel.GetMatchingGroup(c77777754.mfilter,tp,LOCATION_GRAVE,0,nil)
	local mg3=Duel.GetMatchingGroup(c77777754.mfilter,tp,LOCATION_DECK,0,nil)
	local lv=mg3:GetSum(Card.GetLevel)
	b3=Duel.IsExistingMatchingCard(c77777754.costfilter,tp,LOCATION_HAND,0,1,nil,e,tp) 
	local b1=Duel.IsExistingMatchingCard(c77777754.filter2,tp,LOCATION_HAND,0,1,nil,e,tp,lv) 
	and Duel.IsExistingMatchingCard(c77777754.filter3,tp,0,LOCATION_MZONE,1,nil)
	b2=Duel.IsExistingMatchingCard(c77777754.filter,tp,LOCATION_HAND,0,1,nil,e,tp,mg1)
	if chk==0 then return b1 or b2 or b3 end
	local op=0
	if b1 then op=op+1 end
	if b2 then op=op+2 end
	if b3 and not b2 then op=op+2 end
	if op==1 then choice=0 end
	if op==2 then choice=1 end
	if op==3 then choice=Duel.SelectOption(tp,aux.Stringid(77777754,0),aux.Stringid(77777754,1)) end
	e:SetLabel(choice)
 Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c77777754.activate(e,tp,eg,ep,ev,re,r,rp)
	local chc=e:GetLabel()
	if chc==0
	then
	local mg3=Duel.GetMatchingGroup(c77777754.mfilter,tp,LOCATION_DECK,0,nil)
 local lv=mg3:GetSum(Card.GetLevel)
 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
 local tg=Duel.SelectMatchingCard(tp,c77777754.filter2,tp,LOCATION_HAND,0,1,1,nil,e,tp,lv)
 local tc=tg:GetFirst()
 if tc then
 local lv=tc:GetLevel()
	local mat=Group.CreateGroup()
	Duel.DisableShuffleCheck()
	while lv>0 do
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local cst=g:GetFirst()
	if cst:IsType(TYPE_MONSTER) and cst:IsCanBeRitualMaterial(tc,tc) then
	lv2=cst:GetLevel()
	lv=lv-lv2
	mat:AddCard(cst)
	Duel.Remove(cst,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
	else
	Duel.Remove(cst,POS_FACEUP,REASON_EFFECT)
	end
	end
	tc:SetMaterial(mat)
 Duel.BreakEffect()
	if Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)~=0 then
	if tc:GetFlagEffect(7777775401)==0 then
		 --piercing
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(77777754,1))
 		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
 		e1:SetType(EFFECT_TYPE_SINGLE)
 		e1:SetCode(EFFECT_PIERCE)
 		tc:RegisterEffect(e1,tp)
 		tc:RegisterFlagEffect(7777775401,RESET_EVENT+0x1fe0000,0,1)
 		end
	end
 tc:CompleteProcedure()
 end
 else
 local mg1=Duel.GetRitualMaterial(tp)
-- local mg2=Duel.GetMatchingGroup(c77777754.mfilter,tp,LOCATION_GRAVE,0,nil)
 local tg1=Duel.GetMatchingGroup(c77777754.filter,tp,LOCATION_HAND,0,nil,e,tp,mg1)
 local tc1=tg1:GetFirst()
 while tc1 do
 tc1:RegisterFlagEffect(77777754,RESET_EVENT+0x1fe0000+RESET_CHAIN,0,1)
 tc1=tg1:GetNext()
 end
 local tg2=Duel.GetMatchingGroup(c77777754.costfilter,tp,LOCATION_HAND,0,nil,e,tp)
 local tc1=tg2:GetFirst()
 while tc1 do
 tc1:RegisterFlagEffect(77777748,RESET_EVENT+0x1fe0000+RESET_CHAIN,0,1)
 tc1=tg2:GetNext()
 end
 tg1:Merge(tg2)
 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
 local tg=tg1:Select(tp,1,1,nil,nil)
 local tc=tg:GetFirst()
 if tc:GetFlagEffect(77777754)>0 and tc:GetFlagEffect(77777748)>0 and Duel.SelectYesNo(tp,aux.Stringid(77777754,2)) then c=1 else c=0 end
 if tc:GetFlagEffect(77777754)>0 and tc:GetFlagEffect(77777748)==0 then c=0 end
 if tc:GetFlagEffect(77777754)==0 and tc:GetFlagEffect(77777748)>0 then c=1 end 
 if c==0 then
 local mg=mg1:Filter(Card.IsCanBeRitualMaterial,tc,tc)
 if tc.mat_filter then
 mg=mg:Filter(tc.mat_filter,nil)
 end
 local lvt=tc:GetLevel()
 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
 local mat=mg:SelectWithSumGreater(tp,Card.GetRitualLevel,tc:GetLevel(),tc)
 if mg:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE) then
 local a=mat:GetFirst()
 while a do
 mg:RemoveCard(a)
 a=mat:GetNext()
 end
 if mg:GetSum(Card.GetLevel)+mat:GetSum(Card.GetLevel)>=lvt then
 if mat:GetSum(Card.GetLevel)<lvt and Duel.SelectYesNo(tp,aux.Stringid(77777754,3))then
 local b=1
 while b>0 do
 local a=mat:GetFirst()
 while a do
 mg:RemoveCard(a)
 a=mat:GetNext()
 end
 local mat2=mg:SelectWithSumGreater(tp,Card.GetRitualLevel,1,tc)
 mat:Merge(mat2)
 local a=mat2:GetFirst()
 while a do
 mg:RemoveCard(a)
 a=mat2:GetNext()
 end
 b=0
 if mat:GetSum(Card.GetLevel)<lvt and Duel.SelectYesNo(tp,aux.Stringid(77777754,3)) then b=1 end
 end
 end
 end
 end
 tc:SetMaterial(mat)
	Duel.Remove(mat,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
 Duel.BreakEffect()
 if Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)~=0 then
 if tc:GetFlagEffect(7777775401)==0 then
  --piercing
 local e1=Effect.CreateEffect(e:GetHandler())
 e1:SetDescription(aux.Stringid(77777754,1))
 e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
 e1:SetType(EFFECT_TYPE_SINGLE)
 e1:SetCode(EFFECT_PIERCE)
 tc:RegisterEffect(e1,tp)
 tc:RegisterFlagEffect(7777775401,RESET_EVENT+0x1fe0000,0,1)
 end
 end
 tc:CompleteProcedure()
 else 
 local ts=Duel.SelectMatchingCard(tp,c77777754.costfilter2,tp,LOCATION_SZONE,0,1,1,nil,e,tp,tc:GetLevel())
 local tc1=ts:GetFirst()
 tc1:RemoveCounter(tp,0x666,tc:GetLevel(),REASON_COST)
 Duel.BreakEffect()
 if Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)~=0 then
  	if tc:GetFlagEffect(7777775401)==0 then
 		--piercing
 		local e1=Effect.CreateEffect(e:GetHandler())
 		e1:SetDescription(aux.Stringid(77777754,1))
 		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
 		e1:SetType(EFFECT_TYPE_SINGLE)
 		e1:SetCode(EFFECT_PIERCE)
 		tc:RegisterEffect(e1,tp)
 		tc:RegisterFlagEffect(7777775401,RESET_EVENT+0x1fe0000,0,1)
	end
 	if tc:GetFlagEffect(77777748)==0 then
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetDescription(aux.Stringid(77777748,4))
		e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e4:SetType(EFFECT_TYPE_IGNITION)
		e4:SetRange(LOCATION_MZONE)
		e4:SetCountLimit(1)
		e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CLIENT_HINT)
		e4:SetTarget(c77777754.sstg)
		e4:SetOperation(c77777754.ssop)
		tc:RegisterEffect(e4,true)
		tc:RegisterFlagEffect(77777748,RESET_EVENT+0x1fe0000,0,1)
	end
 end
 tc:CompleteProcedure()
 end
end
end 

function c77777754.ssfilter(c,e,tp)
	return c:IsSetCard(0x1c8) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c77777754.ssfilter2(c)
	return c:IsSetCard(0x1c8)
end
function c77777754.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=0
		and Duel.IsExistingMatchingCard(c77777754.ssfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c77777754.ssop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c77777754.ssfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
	 Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) 
	end
end
