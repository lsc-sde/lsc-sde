insert into webapi.cohort_definition ( id, name, description, expression_type, created_by, created_date, modified_by, modified_date) values
(
1, 'Demo new users of diclofenac', 'New users of diclofenac', 'SIMPLE_EXPRESSION', 'ohdsi', '2019-11-19 21:41:12.875', 'ohdsi', '2019-11-19 21:43:44.182'
);

insert into webapi.cohort_definition_details (id, expression) values
(
1,'{"cdmVersionRange":">=5.0.0","PrimaryCriteria":{"CriteriaList":[{"DrugEra":{"CodesetId":0,"First":true,"AgeAtStart":{"Value":16,"Op":"gte"}}}],"ObservationWindow":{"PriorDays":365,"PostDays":0},"PrimaryCriteriaLimit":{"Type":"First"}},"ConceptSets":[{"id":0,"name":"diclofenac","expression":{"items":[{"concept":{"CONCEPT_ID":1124300,"CONCEPT_NAME":"Diclofenac","STANDARD_CONCEPT":"S","STANDARD_CONCEPT_CAPTION":"Standard","INVALID_REASON":"V","INVALID_REASON_CAPTION":"Valid","CONCEPT_CODE":"3355","DOMAIN_ID":"Drug","VOCABULARY_ID":"RxNorm","CONCEPT_CLASS_ID":"Ingredient"},"isExcluded":false,"includeDescendants":true,"includeMapped":false}]}}],"QualifiedLimit":{"Type":"First"},"ExpressionLimit":{"Type":"First"},"InclusionRules":[],"CensoringCriteria":[],"CollapseSettings":{"CollapseType":"ERA","EraPad":0},"CensorWindow":{}}'
);
