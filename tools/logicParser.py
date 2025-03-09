import re
#Progression Items
TeviRuleToPoptacker = {
    "$True":"$True",
    "ITEM_KNIFE":"dagger",
    "I20" : "sable",
    "I19" : "celia",
    "ITEM_ORB": "randged",
    "ITEM_LINEBOMB": "bombs",
    "ITEM_AREABOMB":"bombThrow",
    "ITEM_BOMBFUEL":"bombFuel",
    "ITEM_BombLengthExtend":"bombRange",
    "ITEM_SPEEDUP": "speed",
    "ITEM_AntiIce":"slip",
    "ITEM_SLIDE":"slide",
    "ITEM_AirDash":"airDash",
    "ITEM_HIJUMP":"highJump",
    "ITEM_DOUBLEJUMP":"airJump",
    "ITEM_WALLJUMP":"wallJump",
    "ITEM_WATERMOVEMENT":"water",
    "ITEM_JETPACK":"jetpack",
    "ITEM_AirSlide":"powder",
    "ITEM_Rotater":"vortex",
    "ITEM_PKBADGE":"emblem",
    "ITEM_AntiDecay":"decayAntidote",
    "ITEM_MASK":"decayMask",
    "ITEM_ZCrystal":"alembicCrystal",
    "ITEM_TempRing":"ringTemp",
    "ITEM_Alterscope":"alterscope",
    "ITEM_OrbAmulet":"burst",
    "ITEM_OrbTypeS2":"orbS2",
    "ITEM_OrbTypeS3":"orbS3",
    "ITEM_OrbTypeC3":"orbC3",
    "ITEM_OrbTypeC2":"orbC2",
    "ITEM_BoostSystem":"blueprints",
    "ITEM_OrbBoostU":"boostU",
    "ITEM_OrbBoostD":"boostD",
    "ITEM_AirshipPass":"ticketHeaven",
    "ITEM_AttackRange":"daggerExtend",
    "ITEM_EasyStyle":"daggerCombo",
    "ITEM_RailPass":"ticketHell",
    "ITEM_RapidShots":"orbRapid",
    "ITEM_DodgeShot":"ringDodge",
    "ITEM_GoldenGlove":"gauntlet",
    "ITEM_Explorer":"compass",
    "ITEM_WonderNote":"waffle",
    "ITEM_VenaCharm":"paw",
    "ITEM_Royal":"royal_emblem",
    "QUEST_LibraryKey":"key",
    "QUEST_GHandL":"handLeft",
    "QUEST_GHandR":"handRight",
    "ITEM_GoldenHands":"hands",
    "QUEST_RabiPillow":"pillow",
    "STACKABLE_HP":"hp",
    "STACKABLE_MP":"mp",
    "STACKABLE_EP":"ep",
    "STACKABLE_MATK":"matk",
    "STACKABLE_RATK":"ratk",
    "STACKABLE_SHARD":"shard",
    "STACKABLE_BAG":"bag",
    "Useable_VenaBombSmall":"voidBomb",
    "Useable_VenaBombBig":"cloudBomb",
    "Useable_VenaBombDispel":"calicoBomb",
    "Useable_VenaBombHealBlock":"tabbyBomb",
    "Useable_VenaBombBunBun":"bbRabbit",
    "EVENT_Fire":"fireElement",
    "EVENT_Water":"WaterElement",
    "EVENT_Earth":"earthElement",
    "EVENT_Air":"airElement",
    "EVENT_Light":"lightElement",
    "EVENT_Dark":"darkElement",
    "BackFlip":"backflip",
    "CKick":"ceilingKick",
    "HiddenP":"hiddenPaths",
    "RabbitJump":"rabbitJump",
    "RabbitWalljump":"rabbitWallJump",
    "EarlyDream":"earlyDream",
    "ChargeShot":"$canChargeShot",
    "Coins": "$True",
    "Core":"$canUpgradeCore",
    "VenaBomb":"$canUseVenaBomb",
    "Upgrade" : "$canUpgradeItems",
    "OpenMorose":"openMorose",
    "SpinnerBash":"[$hasAmoun|dagger|1],false",
    "LibraryExtra":"[SuperBoss]"
}



isExpr = lambda s: not isinstance(s, str)

def parse_expression_logic(line):
    if line == "" or line == "()":
        line = "$True"
    line = line.replace('&&', '&').replace('||', '|')
    tokens = [s.strip() for s in re.split('([()&|!~])', line) if s.strip()]
    tokens.reverse()  # Reverse for stack processing

    stack = []
    while tokens:
        next = tokens.pop()
        if isExpr(next):
            if not stack:
                stack.append(next)
                continue
            head = stack[-1]
            if head == '&':
                stack.pop()
                exp = stack.pop()
                assert isExpr(exp)
                tokens.append(OpAnd(exp, next))
            elif head == '|':
                stack.pop()
                exp = stack.pop()
                assert isExpr(exp)
                tokens.append(OpOr(exp, next))
            elif head in '!~':
                stack.pop()
                tokens.append(OpNot(next))
            else:
                stack.append(next)
        elif next in '(&|!~':
            stack.append(next)
        elif next == ')':
            exp = stack.pop()
            assert isExpr(exp)
            paren = stack.pop()
            assert paren == '('
            tokens.append(exp)
        else:  # String literal
            tokens.append(OpLit(next))

    assert len(stack) == 1
    logic = distribute_and_over_or(stack[0])
    newLogic =[]
    for log in logic:
        logs = re.sub('([()])', '', str(log))
        logs = logs.replace("AND",",")
        newLogic += [logs]
    return newLogic

class OpLit:
    def __init__(self, name):
        self.name = name
    def expand(self):
        return [self]  # Literals remain unchanged
    def __str__(self):
        itemstack = self.name.split(' ')
        if len(itemstack)>1 and itemstack[0] in TeviRuleToPoptacker:
            if TeviRuleToPoptacker[itemstack[0]] == "True":
                return "$True"
            elif not '$' in TeviRuleToPoptacker[itemstack[0]]:
                return f"$hasAmount|{TeviRuleToPoptacker[itemstack[0]]}|{itemstack[1]}"
            else:
                return TeviRuleToPoptacker[itemstack[0]]
        elif self.name in TeviRuleToPoptacker:
            f = TeviRuleToPoptacker[self.name]
            return f
        if self.name != "True":
            print(f"{self.name} not found in Poptracker rule conversion")
        return self.name
    __repr__ = __str__

class OpNot:
    def __init__(self, expr):
        self.expr = expr
    def expand(self):
        return [OpNot(exp) for exp in self.expr.expand()]
    def __str__(self):
        return f"(NOT {self.expr})"
    __repr__ = __str__

class OpOr:
    def __init__(self, exprL, exprR):
        self.exprL = exprL
        self.exprR = exprR
    def expand(self):
        left_expanded = self.exprL.expand()
        right_expanded = self.exprR.expand()
        return left_expanded + right_expanded  # Collect all OR parts separately
    def __str__(self):
        return f"({self.exprL} OR {self.exprR})"
    __repr__ = __str__

class OpAnd:
    def __init__(self, exprL, exprR):
        self.exprL = exprL
        self.exprR = exprR
    def expand(self):
        left_expanded = self.exprL.expand()
        right_expanded = self.exprR.expand()
        return [OpAnd(l, r) for l in left_expanded for r in right_expanded]  # Cartesian Product
    def __str__(self):
        return f"({self.exprL} AND {self.exprR})"
    __repr__ = __str__

def distribute_and_over_or(expression):
    return expression.expand()