:- encoding(utf8).
:- module(monarch_historical_facts, [historical_case/5, case_effect/3]).
% Source-linked textual mentions. Not measured clinical effects.
historical_case('S001','BLUEBIRD','Project BLUEBIRD authorization and research plan','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2024-12-23/cia-behavior-control-experiments-focus-new-scholarly',documented).
historical_case('S002','BLUEBIRD','BLUEBIRD interrogations of Korean prisoners','https://nsarchive.gwu.edu/media/33966/ocr',documented).
historical_case('S003','ARTICHOKE','Project ARTICHOKE interrogation case','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2024-12-23/cia-behavior-control-experiments-focus-new-scholarly',documented).
historical_case('S004','BLUEBIRD / ARTICHOKE','CIA–foreign intelligence meeting on mind-control research','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2024-12-23/cia-behavior-control-experiments-focus-new-scholarly',documented).
historical_case('S005','MKULTRA-linked CIA/SOD research','Frank Olson unwitting LSD exposure','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2024-12-23/cia-behavior-control-experiments-focus-new-scholarly',documented).
historical_case('S006','MKULTRA-linked CIA/SOD research','Frank Olson death and contested interpretation','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2025-10-30/top-secret-testimony-cias-mkultra-chief-50-years-later',documented).
historical_case('S007','MKULTRA','George Hunter White New York safehouse','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2025-10-30/top-secret-testimony-cias-mkultra-chief-50-years-later',documented).
historical_case('S008','MKULTRA / Operation Midnight Climax','George Hunter White San Francisco safehouse','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2025-10-30/top-secret-testimony-cias-mkultra-chief-50-years-later',documented).
historical_case('S009','MKULTRA Subproject 35','Georgetown University Hospital cover arrangement','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2024-12-23/cia-behavior-control-experiments-focus-new-scholarly',documented).
historical_case('S010','MKULTRA-linked research','CIA-funded Allan Memorial Institute work','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2024-12-23/cia-behavior-control-experiments-focus-new-scholarly',documented).
historical_case('S011','MKULTRA-linked Allan Memorial Institute work','Velma Orlikow legal challenge','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2024-12-23/cia-behavior-control-experiments-focus-new-scholarly',documented).
historical_case('S012','MKULTRA-linked Allan Memorial Institute work','Linda Macdonald first-person account','https://madnesscanada.com/wp-content/uploads/2020/01/SR-Linda-chapter.pdf',contextual).
historical_case('S013','MKULTRA-linked Allan Memorial Institute work','Nancy Layton interview','https://www.wbur.org/endlessthread/2020/04/24/madness-part-one-the-sleep-room',contextual).
historical_case('S014','Allan Memorial Institute / disputed MKULTRA links','Lana Ponting testimony','https://ocpm.qc.ca/sites/default/files/pdf/P116/8-1_kahnistensera_mohawk_mothers.pdf',unverified).
historical_case('S015','MKULTRA','MKULTRA record destruction','https://www.intelligence.senate.gov/1977/08/03/hearings-joint-hearing-subcommittee-health-and-scientific-research-committee-human-resources-project/',documented).
historical_case('S016','MKULTRA','1977 Senate hearings on MKULTRA','https://www.intelligence.senate.gov/1977/08/03/hearings-joint-hearing-subcommittee-health-and-scientific-research-committee-human-resources-project/',documented).
historical_case('S017','MKULTRA','Sidney Gottlieb testimony on covert experiments','https://nsarchive.gwu.edu/briefing-book/dnsa-intelligence/2025-10-30/top-secret-testimony-cias-mkultra-chief-50-years-later',documented).
historical_case('S018','Alleged Project MONARCH','Cathy O’Brien MONARCH narrative','https://books.google.com/books/about/Trance_Formation_of_America.html?id=WntjswEACAAJ',unverified).
historical_case('S019','Alleged Project MONARCH','Brice Taylor MONARCH-associated narrative','https://fightingmonarch.com/wp-content/uploads/2018/06/thanks-for-the-memories.pdf',unverified).
historical_case('S020','Alleged Project MONARCH','Academic assessment of MONARCH allegations','https://link.springer.com/chapter/10.1007/978-3-031-41850-1_3',unverified).
historical_case('S021','Alleged Project MONARCH','MONARCH butterfly symbols and cue narratives','https://link.springer.com/chapter/10.1007/978-3-031-41850-1_3',unverified).
historical_case('S022','BLUEBIRD / ARTICHOKE','Korean War mind-control concerns vs empirical evidence','https://nsarchive.gwu.edu/media/33966/ocr',documented).
case_effect('S001',drug_exposure,textual_mention_only).
case_effect('S001',hypnosis,textual_mention_only).
case_effect('S001',coercive_context,textual_mention_only).
case_effect('S002',drug_exposure,textual_mention_only).
case_effect('S002',coercive_context,textual_mention_only).
case_effect('S003',memory_or_amnesia,textual_mention_only).
case_effect('S003',drug_exposure,textual_mention_only).
case_effect('S003',hypnosis,textual_mention_only).
case_effect('S003',coercive_context,textual_mention_only).
case_effect('S005',drug_exposure,textual_mention_only).
case_effect('S007',drug_exposure,textual_mention_only).
case_effect('S007',coercive_context,textual_mention_only).
case_effect('S008',drug_exposure,textual_mention_only).
case_effect('S008',coercive_context,textual_mention_only).
case_effect('S009',drug_exposure,textual_mention_only).
case_effect('S010',distress_or_harm,textual_mention_only).
case_effect('S010',electroshock,textual_mention_only).
case_effect('S012',memory_or_amnesia,textual_mention_only).
case_effect('S012',distress_or_harm,textual_mention_only).
case_effect('S013',distress_or_harm,textual_mention_only).
case_effect('S016',coercive_context,textual_mention_only).
case_effect('S017',coercive_context,textual_mention_only).
case_effect('S018',distress_or_harm,textual_mention_only).
case_effect('S019',coercive_context,textual_mention_only).
case_effect('S020',distress_or_harm,textual_mention_only).
case_effect('S022',drug_exposure,textual_mention_only).
case_effect('S022',hypnosis,textual_mention_only).
case_effect('S022',coercive_context,textual_mention_only).
