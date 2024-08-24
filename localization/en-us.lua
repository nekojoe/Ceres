return {
	['misc'] = {
		['dictionary'] = {
			['k_moon'] = 'Moon',
			['k_perk_pack'] = 'Perk Pack',
			['k_perk_card'] = 'Perk Card',
		},
		['suits_plural'] = {
			['cere_Leaves'] = 'Leaves',
			['cere_Crowns'] = 'Crowns',
			['cere_Coins'] = 'Coins',
		},
		['poker_hands'] = {
			['cere_six_of_a_kind'] = 'Six of a Kind',
			['cere_flush_six'] = 'Flush Six',
		},
		['poker_hand_descriptions'] = {
			['cere_six_of_a_kind'] = {
				'6 cards with the same rank',
			},
			['cere_flush_six'] = {
				'6 cards with the same rank and suit',
			},
		},
		['suits_singular'] = {
			['cere_Leaves'] = 'Leaf',
			['cere_Crowns'] = 'Crown',
			['cere_Coins'] = 'Coin',
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
					--'each hand',
				},
			}
		},
		['Enhanced'] = {
			['m_cere_illusion'] = {
                ['name'] = 'Illusion Card',
                ['text'] = {
					'{C:green}#1# in #3#{} chance',
					'for {X:chips,C:white} X#2# {} chips',
					'{C:green}#1# in #4#{} chance',
					'to be retriggered',
				},
            },
			['m_cere_cobalt'] = {
                ['name'] = 'Cobalt Card',
                ['text'] = {
                    '{X:chips,C:white} X#1# {} chips',
                    'while this card',
                    'stays in hand'
                }
            },
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
		['Planet'] = {
			['c_cere_charon'] = {
				['name'] = 'Charon',
				['text'] = {
					'{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up',
					'{C:attention}Six of a Kind{}',
					'{C:red}+#2#{} Mult and',
					'{C:blue}+#3#{} chips',
				},
			},
			['c_cere_ganymede'] = {
				['name'] = 'Ganymede',
				['text'] = {
					'{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up',
					'{C:attention}Flush Six{}',
					'{C:red}+#2#{} Mult and',
					'{C:blue}+#3#{} chips',
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
				['text']= {
					'If first hand scores',
					'less than {C:attention}#1#%{} of Blind',
					'requirement, gain {C:blue}+#2#{} hand',
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
			-- rare
			['j_cere_fox_devil'] = {
				['name'] = 'Fox Devil',
				['text'] = {
					'Small and Big Blinds',
					'are {C:attention}#1#% more{}, Boss',
					'Blinds are {C:attention}#2#% less{}',
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
					'{s:0.8}Card changes every round',
				},
			},
			-- epic
			['j_cere_ben'] = {
				['name'] = 'Ben',
				['text'] = {
					'{C:green}#1#%{} chance to {C:attention}win{} after',
					'playing a hand',
					'{s:0.8}{C:inactive}(Increases with score){}',
				},
			},
			-- divine
			['j_cere_makima'] = {
				['name'] = 'Makima',
				['text'] = {
					'Retrigger each Joker {C:attention}worth less{}',
					'than this Joker. This Joker gains',
					'{X:dark_edition,C:white} ^#1# {} Mult per retrigger',
					'{C:inactive}(Currently {}{X:dark_edition,C:white} ^#2# {} {C:inactive}Mult){}',
				},
			},
			['j_cere_aizen'] = {
				['name'] = 'Aizen',
				['text'] = {
					'Retrigger all played {C:attention}cards{}. This',
					'Joker gains {X:dark_edition,C:white} ^#1# {} Mult when',
					'each played card is {C:attention}scored{}',
					'{C:inactive}(Currently {}{X:dark_edition,C:white} ^#2# {} {C:inactive}Mult){}',
				},
			},
		},
		['Spectral'] = {
			['c_cere_chromatic'] = {
				['name'] = 'Chromatic',
				['text'] = {
					'Add {C:dark_edition}Colourblind{} to a',
					'random {C:attention}Joker{} or {C:attention}card{}',
					'held in hand',
				}
			},
			['c_cere_camouflage'] = {
				['name'] = 'Camouflage',
				['text'] = {
					'Add {C:dark_edition}Sneaky{} to {C:attention}1{}',
					'selected card in hand',
				}
			},
			['c_cere_consecrated_essence'] = {
				['text'] = {
					'{C:dark_edition}Whispers emanate{}',
					'{C:dark_edition}from within...{}',
				}
			},
		},
		['Perk'] = {
			['pk_cere_prototype'] = {
                ['name'] = 'Prototype',
                ['text'] = {
					'On, play create a',
					'{C:spectral}temporary{} {C:attention}#1#{}',
					'and {C:red}burn{} this card.',
				},
			},
			['pk_cere_dirty_napkin'] = {
                ['name'] = 'Dirty Napkin',
                ['text'] = {
					'On, play create a',
					'{C:spectral}temporary{} {C:attention}#1#{}',
					'and {C:red}burn{} this card.',
				},
			},
			['pk_cere_reward_card'] = {
                ['name'] = 'Reward Card',
                ['text'] = {
					'On play, lose {C:money}$#1#{},',
					'create a {C:attention}#2#{},',
					'and {C:red}burn{} this card.',
				},
			},
			['pk_cere_business_card'] = {
                ['name'] = 'Business Card',
                ['text'] = {
					'On play, lose {C:money}$#1#{},',
					'create a {C:attention}#2#{},',
					'and {C:red}burn{} this card.',
				},
			},
			['pk_cere_trading_card'] = {
                ['name'] = 'Trading Card',
                ['text'] = {
					'On play, destroy any {C:attention}scoring{}',
					'cards. Create a random {C:attention}enhanced{}',
					'card in hand for each card destroyed,',
					'and {C:red}burn{} this card.',
				},
			},
			['pk_cere_plus_two'] = {
                ['name'] = '+2 Card',
                ['text'] = {
					'On play, {C:attention}+#1#{} hand size,',
					'{C:red}burn{} this card.',
				},
			},
		},
		['Voucher'] = {
            ['v_cere_card_spread'] = {
                ['name'] = 'Card Spread',
                ['text'] = {
                    '{C:green}Perk cards{} give {C:attention}+1{} hand',
                    'size while in hand',
                },
            },
            ['v_cere_six_fingers'] = {
                ['name'] = 'Sixth... Finger?',
                ['text'] = {
                    'Allows selecting a {C:green}Perk{}',
                    '{C:green}card{} as an extra sixth',
					'card to play',
                },
            },
		},
		['Other'] = {
			['p_cere_perk_normal_1'] = {
				['name'] = 'Perk Pack',
				['text'] = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{C:green} Perk cards{} to',
					'add to your deck',
				}
			},
			['p_cere_perk_normal_2'] = {
				['name'] = 'Perk Pack',
				['text'] = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{C:green} Perk cards{} to',
					'add to your deck',
				}
			},
			['p_cere_perk_jumbo'] = {
				['name'] = 'Jumbo Perk Pack',
				['text'] = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{C:green} Perk cards{} to',
					'add to your deck',
				}
			},
			['p_cere_perk_mega'] = {
				['name'] = 'Mega Perk Pack',
				['text'] = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{C:green} Perk cards{} to',
					'add to your deck',
				}
			},
		},
	},
}