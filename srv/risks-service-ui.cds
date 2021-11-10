using RiskService from './risk-service';

/*Service expose*/
annotate RiskService.Risks with {
	title       @title: 'TitleX';
	prio        @title: 'PriorityX';
	descr       @title: 'DescriptionX';
	miti        @title: 'MitigationX';
	impact      @title: 'ImpactX';
}

annotate RiskService.Mitigations with {
	ID @(
		UI.Hidden,
		Common: {
		Text: description
		}
	);
	description  @title: 'DescriptionY';
	owner        @title: 'OwnerY';
	timeline     @title: 'TimelineY';
	risks        @title: 'RisksY';
}

annotate RiskService.Risks with @(
	UI: {
		  /*key info of the object*/
		HeaderInfo: {
			TypeName: 'RiskA',
			TypeNamePlural: 'RisksA',
			Title          : {
                $Type : 'UI.DataField',
                Value : title
            },
			Description : {
				$Type: 'UI.DataField',
				Value: descr
			}
		},
		  /*properties exposed as search fields in header bar*/
		SelectionFields: [prio],
		LineItem: [
			{Value: title},
			{Value: miti_ID},
			{
				Value: prio,
				Criticality: criticality
			},
			{
				Value: impact,
				Criticality: criticality
			}
		],
		  /*defines the content of the object page*/
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'}
		],
		FieldGroup#Main: {
			Data: [
				{Value: miti_ID},
				{
					Value: prio,
					Criticality: criticality
				},
				{
					Value: impact,
					Criticality: criticality
				}
			]
		}
	},
) {

};

annotate RiskService.Risks with {
	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.description  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: miti_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'description'
					}
				]
			}
		}
	);
}
