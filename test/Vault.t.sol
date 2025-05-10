// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MockUSDC} from "../src/MockUSDC.sol";
import {Vault} from "../src/Vault.sol";

contract VaultTest is Test {
    MockUSDC public usdc;
    Vault public vault;

    address public alice = makeAddr("Alice");
    address public bob = makeAddr("Bob");
    address public charlie = makeAddr("Charlie");

    function setUp() public {
        usdc = new MockUSDC();
        vault = new Vault(address(usdc));
    }

    function test_Deposit() public {
        // usdc.mint(address(this), 1000);
        // usdc.approve(address(vault), 1000);
        // vault.deposit(1000);
        // assertEq(usdc.balanceOf(address(vault)), 1000);

        vm.startPrank(alice);
        usdc.mint(address(alice), 1000);
        usdc.approve(address(vault), 1000);
        vault.deposit(1000);
        assertEq(vault.balanceOf(address(alice)), 1000);
        vm.stopPrank(); 

        vm.startPrank(bob);
        usdc.mint(address(bob), 2000);
        usdc.approve(address(vault), 2000);
        vault.deposit(2000);
        assertEq(vault.balanceOf(address(bob)), 2000);
        vm.stopPrank();

    }

    function test_Scenario() public {
        // usdc.mint(alice, 1000000);
        // usdc.mint(bob, 2000000);
        // usdc.mint(charlie, 3000000);

        // vm.startPrank(alice);
        // usdc.approve(address(vault), 1000000);
        // vault.deposit(1000000);
        // assertEq(vault.balanceOf(address(alice)), 1000000);
        // vm.stopPrank();

        // vm.startPrank(bob);
        // usdc.approve(address(vault), 2000000);
        // vault.deposit(2000000);
        // assertEq(vault.balanceOf(address(bob)), 2000000);
        // vm.stopPrank();

        // vm.startPrank(charlie);
        // usdc.approve(address(vault), 3000000);
        // vault.deposit(3000000); 
        // assertEq(vault.balanceOf(address(charlie)), 3000000);
        // vm.stopPrank();

        // usdc.mint(address(this), 1000000);
        // usdc.approve(address(vault), 1000000);
        // vault.distributedYield(1000000);

        // vm.startPrank(charlie);
        // usdc.approve(address(vault), 1000000);
        // vault.deposit(1000000);
        // vm.stopPrank();

        // persiapkan
        usdc.mint(alice, 1_000_000);
        usdc.mint(bob, 2_000_000);
        usdc.mint(charlie, 1_000_000);

        // alice deposit 1jt
        vm.startPrank(alice);
        usdc.approve(address(vault), 1_000_000);
        vault.deposit(1_000_000);
        assertEq(vault.balanceOf(alice), 1_000_000);
        vm.stopPrank();

        // bob deposit 2jt
        vm.startPrank(bob);
        usdc.approve(address(vault), 2_000_000);
        vault.deposit(2_000_000);
        assertEq(vault.balanceOf(bob), 2_000_000);
        vm.stopPrank();

        // distributeYield 1jt
        usdc.mint(address(this), 1_000_000);
        usdc.approve(address(vault), 1_000_000);
        vault.distributedYield(1_000_000);

        // charlie deposit 1jt
        vm.startPrank(charlie);
        usdc.approve(address(vault), 1_000_000);
        vault.deposit(1_000_000);
        assertEq(vault.balanceOf(charlie), 750_000);
        vm.stopPrank();     
        
    }
}