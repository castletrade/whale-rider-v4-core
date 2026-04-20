"""
Test Suite: Risk Compliance
Purpose: Validates that the Guardian component correctly enforces institutional risk limits.
"""

import unittest
from src.risk.guardian import RiskGuardian

class TestRiskGuardian(unittest.TestCase):
    """
    Unit tests for risk validation logic to ensure deterministic failure 
    under limit-violating conditions.
    """

    def setUp(self):
        self.limits = {"max_notional": 50000.0, "max_slippage_bps": 10.0}
        self.guardian = RiskGuardian(self.limits)

    def test_notional_guard_approval(self):
        """Verifies that orders within limits are correctly approved."""
        self.assertTrue(self.guardian.validate_notional_guard(1, 40000.0))

    def test_notional_guard_rejection(self):
        """Verifies that orders exceeding limits are correctly rejected."""
        self.assertFalse(self.guardian.validate_notional_guard(2, 40000.0))

    def test_slippage_threshold(self):
        """Ensures slippage padding reacts correctly to price deviations."""
        padding = self.guardian.calculate_slippage_padding(105, 100)
        self.assertEqual(padding, 500.0) # 500 bps

if __name__ == "__main__":
    unittest.main()
