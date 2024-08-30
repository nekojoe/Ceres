return {
	['misc'] = {
		['suits_plural'] = {
			['cere_Leaves'] = 'Leaves',
			['cere_Crowns'] = 'Crowns',
			['cere_Coins'] = 'Coins',
		},
		['suits_singular'] = {
			['cere_Leaves'] = 'Leaf',
			['cere_Crowns'] = 'Crown',
			['cere_Coins'] = 'Coin',
		},
		['labels'] = {
			['cere_colourblind'] = 'Colourblind',
			['cere_sneaky'] = 'Sneaky',
			['cere_mint_condition'] = 'Mint Condition',
			['s_cere_green_seal_seal'] = 'Green Seal',
			['cere_defective'] = 'Defective',
		},
		['dictionary'] = {
            ['k_perk_pack'] = "Perk Pack",
		},
	},
	['descriptions'] = {
		['Blind'] = {
			['bl_cere_new_moon'] = {
				['name'] = 'New Moon',
				['text'] = {
					'Debuffs cards with most',
					'common suit or rank',
        		},
			},
			['bl_cere_the_bill'] = {
				['name'] = 'The Bill',
				['text'] = {
					'All Coin cards',
                    'are debuffed',
				}
			},
			['bl_cere_the_fall'] = {
				['name'] = 'The Fall',
				['text'] = {
					'All Leaf cards',
                    'are debuffed',
				}
			},
			['bl_cere_the_french'] = {
				['name'] = 'The French',
				['text'] = {
					'All Crown cards',
                    'are debuffed',
				}
			},
			['bl_cere_gun_devil'] = {
				['name'] = 'Gun Devil',
				['text'] = {
					'#1# in 4 chance for each',
					'card to be debuffed,',
				},
			}
		},
		['reversed_tarot'] = {
			['c_cere_reversed_fool'] = {
                ['name'] = 'The Fool Reversal',
                ['text'] = {
                    'Creates the last',
                    '{C:tarot}Tarot Reversal{} used',
                    'during this run',
                    '{s:0.8,C:tarot}The Fool Reversal{s:0.8} excluded'
                }
            },
			['c_cere_reversed_magician'] = {
                ['name'] = 'The Magician Reversal',
                ['text'] = {
                    'Enhances {C:attention}#1#{}',
                    'selected cards ',
                    'to {C:attention}#2#s'
                }
            },
			['c_cere_reversed_lovers'] = {
                ['name'] = 'The Lovers Reversal',
                ['text'] = {
                    'Converts up to {C:attention}#1#{} selected',
					'cards to the same {C:attention}random suit{}',
                }
            },
			['c_cere_reversed_chariot'] = {
                ['name'] = 'The Chariot Reversal',
                ['text'] = {
                    'Enhances {C:attention}#1#{} selected',
                    'card into a',
                    '{C:attention}#2#'
                }
			},
			['c_cere_reversed_hanged_man'] = {
                ['name'] = 'The Hanged Man Reversal',
                ['text'] = {
					'Add a permanent copy of',
                    '{C:attention}#1#{} selected card to deck',
                }
            },
			['c_cere_reversed_strength'] = {
				['name'] = 'Strength Reversal',
                ['text'] = {
                    'Decreases rank of',
                    'up to {C:attention}#1#{} selected',
                    'cards by {C:attention}1',
                }
			},
			['c_cere_reversed_star'] = {
				['name'] = 'The Star Reversal',
				['text'] = {
					'Converts up to',
					'{C:attention}#1#{} selected cards',
					'to {V:1}#2#{}',
				},
			},
			['c_cere_reversed_sun'] = {
				['name'] = 'The Sun Reversal',
				['text'] = {
					'Converts up to',
					'{C:attention}#1#{} selected cards',
					'to {V:1}#2#{}',
				},
			},
			['c_cere_reversed_world'] = {
				['name'] = 'The World Reversal',
				['text'] = {
					'Converts up to',
					'{C:attention}#1#{} selected cards',
					'to {V:1}#2#{}',
				},
			},
		},
		['Joker'] = {
			-- common
			['j_cere_one_up'] = {
				['name'] = '1 UP',
				['text'] = {
					'Prevents {C:red}Game Over!{}',
					'or rewards {C:money}$#1#{}, lasts',
					'only one round',
				},
			},
			['j_cere_coin_toss'] = {
				['name'] = 'Coin Toss',
				['text'] = {
					'When {C:attention}Blind{} is selected,',
					'{C:green}#1# in 2{} chance to gain',
					'{C:blue}+1{} hand, otherwise',
					'gain {C:red}+1{} discard',
				},
			},
			['j_cere_warm_up'] = {
				['name'] = 'Warm Up',
				['text'] = {
					'If first hand scores',
					'less than {C:attention}#1#%{} of Blind',
					'requirement, gain {C:blue}+#2#{} hand',
				},
			},
			['j_cere_diving_joker'] = {
				['name'] = 'Diving Joker',
				['text'] = {
                    "{C:mult}+#1#{} Mult for every eight",
                    "cards {C:attention}drawn{} this ante",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
			},
			['j_cere_accountant'] = {
				['name'] = 'Accountant',
				['text'] = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "{C:money}$1{} of {C:attention}interest{} earned",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
			},
			['j_cere_museum'] = {
				['name'] = 'Museum',
				['text'] = {
                    "When a Joker is {C:attention}sold{},",
                    "permanently add its",
                    "sell value to this {C:red}Mult{}",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                }
			},
			['j_cere_large_joker'] = {
				['name'] = 'Large Joker',
				['text'] = {
                    "Gains {C:mult}+#2#{} Mult when each",
                    "played {C:attention}Ace{} is scored",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                },
			},
			['j_cere_backup_plan'] = {
				['name'] = 'Backup Plan',
				['text'] = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand contains {C:attention}4{} or",
                    "fewer {C:attention}scoring{} cards"
                }
			},
			['j_cere_club_sandwich'] = {
				['name'] = 'Club Sandwich',
				['text'] = {
                    "Gains {C:mult}+#2#{} Mult if {C:attention}first{}",
                    'and {C:attention}last{} scoring',
					'cards are {C:clubs}Clubs{}',
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                },
			},
			['j_cere_scratchcard'] = {
				['name'] = 'Scratchcard',
				['text'] = {
                    'Gives {C:money}$#1#{} for each',
					'{C:attention}repeat rank{} in hand',
				},
			},
			-- uncommon
			['j_cere_chainsaw_devil'] = {
				['name'] = 'Chainsaw Devil',
				['text'] = {
					'A strangely friendly',
					'Devil, his behaviour',
					'seems quite {C:attention}erratic{}',
				},
			},
			['j_cere_professor'] = {
				['name'] = 'Professor',
				['text'] = {
					'Retrigger all',
					'played {C:attention}#1#s'
				},
			},
			['j_cere_squared'] = {
				['name'] = 'Squared Joker',
				['text'] = {
					'Played cards with',
					'{C:attention}square{} rank give',
					'{C:mult}+#1#{} Mult when scored',
					'{C:inactive}(A, 9, 4)',
				},
			},
			['j_cere_favourable_odds'] = {
				['name'] = 'Favourable Odds',
                ['text'] = {
                    'Played cards with {C:attention}odd{}',
                    'rank become {C:attention}Lucky{}',
                    'cards when scored',
                    '{C:inactive}(A, 9, 7, 5, 3)',
                }
			},
			['j_cere_miku'] = {
				['name'] = 'Hatsune Miku',
                ['text'] = {
					'Gains {X:mult,C:white} X#1# {} Mult when',
                    'playing your highest',
                    'level {C:attention}poker hand{}',
                    '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)'
				},
			},
			['j_cere_marlboro_reds'] = {
				['name'] = 'Marlboro Reds',
                ['text'] = {
					'{X:mult,C:white} X#1# {} Mult, reduces by',
					'{X:mult,C:white}X#2# {} every round',
                }
			},
			['j_cere_skateboard'] = {
				['name'] = 'Skateboard',
                ['text'] = {
					'Gains {X:mult,C:white} X#1# {} Mult for',
					'each {C:attention}unique{} poker hand',
					'played this round, resets',
					'when the round ends',
					'{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)',
				}
			},
			['j_cere_stopwatch'] = {
				['name'] = 'Stopwatch',
                ['text'] = {
					'Gains {X:mult,C:white} X0.01 {} Mult for each',
					'{C:attention}second{} passed this round,',
					'{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)',
				}
			},
			['j_cere_fisherman'] = {
				['name'] = 'Fisherman',
                ['text'] = {
                    "{C:attention}+#1#{} hand size when hand",
					'is {C:attention}played{}, resets at',
					'the end of the round',
				}
			},
			['j_cere_insurance_fraud'] = {
				['name'] = 'Insurance Fraud',
                ['text'] = {
					'Debuff all {C:attention}#1#s{}, earn',
					'{C:money}$#2#{} for each {C:attention}debuffed{}',
					"card in scoring hand",
					'{s:0.8}Rank changes every round',
				},
			},
			['j_cere_seasoning'] = {
				['name'] = 'Seasoning',
                ['text'] = {
					'Add a random {C:enhanced}Enhancement{},',
                    '{C:dark_edition}Edition{}, and {C:attention}Seal{} to next',
					'{C:attention}#1#{} scoring card#2#',
				},
			},
			['j_cere_ghost'] = {
                ['name'] = "Ghost",
                ['text'] = {
                    "Gains {X:mult,C:white} X#1# {} Mult every time",
                    "a {C:spectral}Spectral{} card is used",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
                }
            },
			['j_cere_blacksmith'] = {
                ['name'] = "Blacksmith",
                ['text'] = {
                    "When sold, upgrade all {C:attention}poker{}",
                    "{C:attention}hands{} by {C:attention}#1#{} level#2#. Amount",
					'increases each round'
                }
            },
			-- rare
			['j_cere_fox_devil'] = {
				['name'] = 'Fox Devil',
				['text'] = {
					'Small and Big Blinds',
					'are {C:attention}#1#%{} more, Boss',
					'Blinds are {C:attention}#2#%{} less',
				},
			},
			['j_cere_blood_fiend'] = {
				['name'] = 'Blood Fiend',
				['text'] = {
					'Gains {X:mult,C:white} X#1# {} Mult for',
					'every destroyed card',
					'with {C:hearts}Heart{} suit',
					'{C:inactive}(Currently {}{X:mult,C:white} X#2# {} {C:inactive}Mult){}'
				},
			},
			['j_cere_snake_eyes'] = {
				['name'] = 'Snake Eyes',
				['text'] = {
					'Retrigger all {C:attention}Jokers{}',
					'and {C:attention}cards{} with {C:green}chance{}',
					'related effects',
				},
			},
			['j_cere_calling_the_clock'] = {
				['name'] = 'Calling the Clock',
				['text'] = {
					'Retrigger all {C:attention}#1#s{}, both',
					'played and held in hand',
					'{s:0.8}Rank changes every round',
				},
			},
			['j_cere_ben'] = {
				['name'] = 'Ben',
				['text'] = {
					'{C:green}#1#%{} chance to {C:attention}win{} after',
					'playing a hand',
					'{s:0.8}{C:inactive}(Increases with score){}',
				},
			},
			['j_cere_double_down'] = {
				['name'] = 'Double Down',
                ['text'] = {
                    'Retrigger all cards held',
					'in hand {C:attention}twice{}, if played',
                    'hand contains a {C:attention}Pair{}',
                }
			},
			['j_cere_yumeko'] = {
				['name'] = 'Yumeko',
                ['text'] = {
					'Played cards with',
                    '{V:1}#2#{} suit give {X:mult,C:white} X#1# {}',
                    'Mult when scored',
                    '{s:0.8}Suit changes every round'
                }
			},
			['j_cere_wanted_poster'] = {
				['name'] = 'Wanted Poster',
                ['text'] = {
					"When {C:attention}Blind{} is selected,",
                    "destroy a random {V:1}#1#{}",
                    "Joker and gain {X:mult,C:white} X1 {} Mult",
                    '{s:0.8}Rarity changes when upgraded',
                    '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)',
				}
			},
			['j_cere_the_solo'] = {
				['name'] = 'The Solo',
				['text'] = {
                    '{X:mult,C:white} X#1# {} Mult if played',
                    'hand contains',
                    'a {C:attention}High Card{}'
                },
			},
			['j_cere_bismuth_crystal'] = {
				['name'] = 'Bismuth Crystal',
				['text'] = {
                    "{C:attention}Stone{} cards give",
                    "{X:mult,C:white} X#1# {} Mult when scored",
                },
			},
			['j_cere_poltergeist'] = {
				['name'] = 'Poltergeist',
				['text'] = {
                    "Create a {C:spectral}Spectral{} card",
                    "when {C:attention}Blind{} is selected,",
					'Blinds are {C:attention}#1#%{} more',
                    "{C:inactive}(Must have room)",
                },
			},
			-- legendary
			['j_cere_traveling_merchant'] = {
				['name'] = 'Traveling Merchant',
                ['text'] = {
					'{C:tarot}if{} {C:blue}context{}.{C:green}setting_blind{} {C:tarot}then{}   ',
					'  {C:spectral}local{} {C:blue}negative{} = {C:spectral}true{}     ',
					'  {C:tarot}if{} {C:blue}joker_slot{} == {C:attention}1{} {C:tarot}then{}   ',
					'    {C:attention}create_card({}{C:tarot}Tarot{C:attention}){}',
					'  {C:tarot}elseif{} {C:blue}joker_slot{} == {C:attention}2{} {C:tarot}then{}',
					'    {C:attention}create_card({}{C:planet}Planet{C:attention}){}',
					'  {C:tarot}elseif{} {C:blue}joker_slot{} == {C:attention}3{} {C:tarot}then{}',
					'      {C:attention}create_card({}{C:spectral}Spectral{C:attention}){}',
					'  {C:tarot}end{}					  ',
					'{C:tarot}end{}					  	',
				}
			},
			-- divine
			['j_cere_makima'] = {
				['name'] = 'Makima',
				['text'] = {
					'Jokers {C:attention}worth less{}',
					'than this Joker',
					"each give {X:dark_edition,C:white} ^#1# {} Mult",
				},
			},
			['j_cere_aizen'] = {
				['name'] = 'Aizen',
				['text'] = {
                    "Each card",
                    "held in {C:attention}hand{}",
                    "gives {X:dark_edition,C:white} ^#1# {} Mult",

                }
			},
		},
		['Back'] = {
			['b_cere_scratch'] = {
                ['name'] = "Scratch Deck",
                ['text'] = {
                    "Start run with the {C:attention,T:v_hone}Hone{}",
					"and {C:attention,T:v_clearance_sale}Clearance Sale{} vouchers",
                    "Rerolls cost {C:money}$2{} more",
                }
            },
			['b_cere_soul'] = {
                ['name'] = "Soul Deck",
                ['text'] = {
					"Start run with an {C:eternal,T:sticker_eternal}eternal{}",
					"{C:legendary,E:1}Legendary{} Joker",
                }
            },
			['b_cere_gift'] = {
                ['name'] = "Gift Deck",
                ['text'] = {
                    "Start run with the ",
					'{C:attention,T:v_cere_overflow_norm}Overflow{} voucher',
					"and an extra {C:money}$#1#",
                }
            },
			['b_cere_golden'] = {
                ['name'] = "Golden Deck",
                ['text'] = {
                    "{C:money}$#1#{} for each card in",
					'{C:attention}hand{} at end of round',
					'Earn no {C:attention}interest',
                }
            },
		},
		['Spectral'] = {
			['c_cere_chromatic'] = {
				['name'] = 'Chromatic',
				['text'] = {
					'Add {C:dark_edition}Colourblind{} to a',
					'random {C:attention}Joker{} or {C:attention}1{}',
					'selected card in hand',
				}
			},
			['c_cere_camouflage'] = {
				['name'] = 'Camouflage',
				['text'] = {
					'Add {C:dark_edition}Sneaky{} to a',
					'random {C:attention}Joker{} or {C:attention}1{}',
					'selected card in hand',
				}
			},
			['c_cere_ceres_spectral'] = {
				['name'] = 'Ceres',
				['text'] = {
                    "Creates a",
                    "{C:dark_edition,E:1}Divine{} Joker",
                    "{C:inactive}(Must have room)"
                }
			},
			['c_cere_magnet'] = {
				['name'] = 'Magnet',
				['text'] = {
                    "Add a {C:green}Green Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand"
                }
			},
			['c_cere_card_sleeve'] = {
				['name'] = 'Card Sleeve',
				['text'] = {
					'Add {C:dark_edition}Mint Condition{} to a',
					'random {C:attention}Joker{} or {C:attention}1{}',
					'selected card in hand',
				}
			},
		},
		['Edition'] = {
			['e_cere_colourblind'] = {
				['name'] = "Colourblind",
				['text'] = {
					"{X:chips,C:white} X#1# {} Chips",
					'{X:mult,C:white} X#2# {} Mult',
        		}
			},
			['e_cere_sneaky'] = {
				['name'] = "Sneaky",
				['text'] = {
					"This card cannot",
					"be {C:attention}debuffed{}",
				},
			},
			['e_cere_mint_condition'] = {
				['name'] = "Mint Condition",
				['text'] = {
					'{X:money,C:white} X#1# {} Dollars',
				}
			},
		},
		['Voucher'] = {
			['v_cere_reflection'] = {
                ['name'] = 'Reflection',
                ['text'] = {
					"{C:dark_edition}Negative{} cards appear",
                    "{C:attention}#1#X{} more often"
				},
            },
            ['v_cere_shattered_mirror'] = {
                ['name'] = 'Shattered Mirror',
                ['text'] = {
					"{C:dark_edition}Negative{} cards appear",
                    "{C:attention}#1#X{} more often"
				},
            },
			['v_cere_glimmer'] = {
                ['name'] = 'Glimmer',
                ['text'] = {
                    "{C:dark_edition}Colourblind{}, {C:dark_edition}Sneaky{}, and",
                    "{C:dark_edition}Mint Condition{} cards",
                    "appear {C:attention}#1#X{} more often"
                }
            },
            ['v_cere_iridescent'] = {
                ['name'] = 'Iridescent',
                ['text'] = {
                    "{C:dark_edition}Colourblind{}, {C:dark_edition}Sneaky{}, and",
                    "{C:dark_edition}Mint Condition{} cards",
                    "appear {C:attention}#1#X{} more often"
                }
            },
			['v_cere_supernatural'] = {
                ['name'] = 'Supernatural',
                ['text'] = {
                    "{C:spectral}Spectral{} cards may",
                    "appear in the shop",
                }
            },
            ['v_cere_ethereal'] = {
                ['name'] = 'Ethereal',
                ['text'] = {
                    "{C:spectral}Spectral{} cards",
                    "appear {C:attention}#1#X{} more often"
                }
            },
			['v_cere_overflow_norm'] = {
                ['name'] = 'Overflow',
                ['text'] = {
                    "{C:attention}+1{} booster slot",
                    "available in shop"
                }
            },
			['v_cere_overflow_plus'] = {
                ['name'] = 'Overflow Plus',
                ['text'] = {
                    "{C:attention}+1{} booster slot",
                    "available in shop"
                }
            },
		},
		['Perk'] = {
			['perk_cere_prototype'] = {
				['name'] = 'Prototype',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'create a {C:eris_temporary}temporary{} {C:attention}Blueprint{},',
					'then {E:1,C:red}burn{}',
				},
			},
			['perk_cere_dirty_napkin'] = {
				['name'] = 'Dirty Napkin',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'create a {C:eris_temporary}temporary{} {C:attention}Brainstorm{},',
					'then {E:1,C:red}burn{}',
				},
			},
			['perk_cere_reward_card'] = {
				['name'] = 'Reward Card',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'create a {C:attention}Coupon Tag{},',
					'then {E:1,C:red}burn{}',
				},
			},
			['perk_cere_business_card'] = {
				['name'] = 'Business Card',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'create a {C:attention}Uncommon Tag{},',
					'then {E:1,C:red}burn{}',
				},
			},
			['perk_cere_plus_two'] = {
				['name'] = '+2 Card',
				['text'] = {
					'On {E:1,C:green}exploit{}:',
					'gain {C:attention}+#1#{} hand size,',
					'then {E:1,C:red}burn{}',
				},
			},
		},
		['Other'] = {
			['p_cere_perk_normal_1'] = {
			    ['name'] = "Perk Pack",
			    ['text'] = {
			        "Choose {C:attention}1{} of up to",
			        "{C:attention}3{C:green} Perk{} cards"
			    }
			},
			['p_cere_perk_normal_2'] = {
			    ['name'] = "Perk Pack",
			    ['text'] = {
			        "Choose {C:attention}#1#{} of up to",
			        "{C:attention}#2#{C:green} Perk{} cards"
			    }
			},
            ['p_cere_perk_jumbo'] = {
                ['name'] = "Jumbo Perk Pack",
                ['text'] = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Perk{} cards"
                }
            },
            ['p_cere_perk_mega'] = {
                ['name'] = "Mega Perk Pack",
                ['text'] = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Perk{} cards"
                }
            },
			-- seals
			['s_cere_green_seal_seal'] = {
				['name'] = "Green Seal",
				['text'] = {
					'{C:green}#1# in #2#{} chance',
					'to {C:attention}return{} to',
					'hand after play',
				}
			},
			-- divine joker info
			['makima_info'] = {
				['name'] = 'Makima',
				['text'] = {
					'A {C:cere_dark_red}corpse{}',
					'is talking',
				},
			},
			['aizen_info'] = {
				['name'] = 'Aizen',
				['text'] = {
					'Welcome, to my',
					'{C:spectral}Soul Society{}',
				},
			},
		},
	},
}